#!/usr/bin/env bash

# Declare global arrays to hold the monitor data
declare -a MON_IDS
declare -a MON_MODELS
declare -a MON_BRIGHTNESS
declare -a MON_CONTRAST

# Define ANSI Color Codes (Regular text colors)
COLOR_GREEN='\033[1;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_CYAN='\033[1;36m'
COLOR_RED='\033[1;31m'
COLOR_RESET='\033[0m' # Resets color back to default terminal text

# VCP feature 10 is Brightness
BRIGHTNESS_VCP_CODE="10"
CONTRAST_VCP_CODE="12"

# Ensure ddcutil is present
if ! command -v ddcutil &>/dev/null; then
  echo "Error: ddcutil is not installed. Please install it first." >&2
  exit 1
fi

#----------------------------------------
# Detects connected monitors and populates global identity arrays.
#
# Parses the output of 'ddcutil detect' to extract hardware display indicies
# and monitor model strings, appending them to MON_IDS and MON_MODELS
#
# Gloabls:
#   MON_IDS (Modified)
#   MON_MODELS (Modified)
# Arguments:
#   None
# Outputs:
#   None
#----------------------------------------
get_monitor_details() {
  # Run ddcutil detect command to get the details of each monitor connected
  while IFS="|" read -r display_num model_name; do

    # Append the values into our global arrays
    MON_IDS+=("$display_num")
    MON_MODELS+=("$model_name")
  done < <(ddcutil detect | awk '/Display/ {disp=$2} /Model:/ {$1=""; sub(/^[[:space:]]+/, ""); print disp "|" $0}')
}

#----------------------------------------
# Queries a monitor's current hardware brightness level.
#
# Looks up the hardware display ID from MON_IDS using a provided index,
# queries the device via ddcutil, and stores the formatted result string
# (e.g., "80/100") into the MON_BRIGHTNESS array.
#
# Globals:
#   MON_IDS (Read)
#   MON_BRIGHTNESS (Modified)
#   VCP_CODE (Read)
# Arguments:
#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Declare global arrays to handle an arbitrary number of connected monitors
declare -a MON_IDS
declare -a MON_MODELS
declare -a MON_BRIGHTNESS
declare -a MON_CONTRAST

# Define ANSI Color Codes for terminal prettification
COLOR_BRIGHT='\033[0;33m'   # Yellow/Amber
COLOR_CONTRAST='\033[0;34m' # Blue
COLOR_GREEN='\033[0;32m'    # Green for success
COLOR_RESET='\033[0m'       # Resets color back to default

# VCP feature codes
BRIGHTNESS_VCP_CODE="10"
CONTRAST_VCP_CODE="12"

# Ensure ddcutil is present
if ! command -v ddcutil &>/dev/null; then
  echo "Error: ddcutil is not installed. Please install it first." >&2
  exit 1
fi

#----------------------------------------
# Core Functions
#----------------------------------------

get_monitor_details() {
  # Dynamically build the monitor map using the block-aware awk filter
  while IFS="|" read -r display_num model_name; do
    MON_IDS+=("$display_num")
    MON_MODELS+=("$model_name")
  done < <(ddcutil detect | awk '/Display/ {disp=$2} /Model:/ {$1=""; sub(/^[[:space:]]+/, ""); print disp "|" $0}')
}

get_hardware_value() {
  local display_id="$1"
  local vcp_code="$2"
  # Cleanly pull the current live integer value using standard space splitting
  ddcutil getvcp "$vcp_code" --display "$display_id" --terse 2>/dev/null | awk '{print $4}'
}

set_hardware_value() {
  local display_id="$1"
  local vcp_code="$2"
  local value="$3"
  ddcutil setvcp "$vcp_code" "$value" --display "$display_id" &>/dev/null
}

#----------------------------------------
# Main Logic Execution Flow
#----------------------------------------

# 1. Initialize and populate identity maps
get_monitor_details

if [ ${#MON_IDS[@]} -eq 0 ]; then
  echo "No monitors detected via ddcutil. Ensure your monitors support DDC/CI." >&2
  exit 1
fi

# 2. Populate live display metrics dynamically for the selection menu
for i in "${!MON_IDS[@]}"; do
  id="${MON_IDS[$i]}"
  MON_BRIGHTNESS[$i]=$(get_hardware_value "$id" "$BRIGHTNESS_VCP_CODE")
  MON_CONTRAST[$i]=$(get_hardware_value "$id" "$CONTRAST_VCP_CODE")
done

# 3. Present User Interface Options
echo -e "Which monitor would you like to adjust?"
for i in "${!MON_IDS[@]}"; do
  echo -e "${COLOR_GREEN}$((i + 1)). 󰍹  ${MON_MODELS[$i]}${COLOR_RESET}  ${COLOR_BRIGHT} 󰃝 Brightness: ${MON_BRIGHTNESS[$i]}%${COLOR_RESET} | ${COLOR_CONTRAST}󰆗 Contrast: ${MON_CONTRAST[$i]}%${COLOR_RESET}"
done
echo -e "${COLOR_CYAN}3. 󰍺  All Connected Screens ${COLOR_RESET}"
echo -e "${COLOR_RED}0. 󰈆  Exit ${COLOR_RESET}"
echo -ne "Enter your choice (0-$((${#MON_IDS[@]} == 2 ? 3 : ${#MON_IDS[@]} + 1))): "
read -r screen_choice

# Validate choice options
if [[ "$screen_choice" == "0" ]]; then
  exit 0
fi

# 4. Prompt and Validate Input values
echo -ne "Enter new ${COLOR_BRIGHT}Brightness${COLOR_RESET} value (0-100): "
read -r brightness_value
if [[ ! "$brightness_value" =~ ^[0-9]+$ ]] || [ "$brightness_value" -lt 0 ] || [ "$brightness_value" -gt 100 ]; then
  echo "Invalid brightness value. Please enter an integer between 0 and 100." >&2
  exit 1
fi

echo -ne "Enter new ${COLOR_CONTRAST}Contrast${COLOR_RESET} value (0-100): "
read -r contrast_value
if [[ ! "$contrast_value" =~ ^[0-9]+$ ]] || [ "$contrast_value" -lt 0 ] || [ "$contrast_value" -gt 100 ]; then
  echo "Invalid contrast value. Please enter an integer between 0 and 100." >&2
  exit 1
fi

# 5. Process Updates based on selection
echo -e "\nApplying updates via I2C bus..."

case "$screen_choice" in
  1 | 2)
    # Map selection back to 0-indexed array target
    idx=$((screen_choice - 1))
    target_id="${MON_IDS[$idx]}"

    if [ -z "$target_id" ]; then
      echo "Invalid selection choice." >&2
      exit 1
    fi

    set_hardware_value "$target_id" "$BRIGHTNESS_VCP_CODE" "$brightness_value"
    set_hardware_value "$target_id" "$CONTRAST_VCP_CODE" "$contrast_value"

    # Read back confirmations
    new_b=$(get_hardware_value "$target_id" "$BRIGHTNESS_VCP_CODE")
    new_c=$(get_hardware_value "$target_id" "$CONTRAST_VCP_CODE")
    echo -e "Screen $screen_choice (${MON_MODELS[$idx]}): Brightness is now ${COLOR_BRIGHT}${new_b}%${COLOR_RESET}, Contrast is now ${COLOR_CONTRAST}${new_c}%${COLOR_RESET}"
    ;;

  3)
    # Dynamic loop updating every display found in the array system
    for i in "${!MON_IDS[@]}"; do
      target_id="${MON_IDS[$i]}"
      set_hardware_value "$target_id" "$BRIGHTNESS_VCP_CODE" "$brightness_value"
      set_hardware_value "$target_id" "$CONTRAST_VCP_CODE" "$contrast_value"

      new_b=$(get_hardware_value "$target_id" "$BRIGHTNESS_VCP_CODE")
      new_c=$(get_hardware_value "$target_id" "$CONTRAST_VCP_CODE")
      echo -e "Screen $((i + 1)) (${MON_MODELS[$i]}): Brightness is now ${COLOR_BRIGHT}${new_b}%${COLOR_RESET}, Contrast is now ${COLOR_CONTRAST}${new_c}%${COLOR_RESET}"
    done
    ;;

  *)
    echo "Invalid choice options selection." >&2
    exit 1
    ;;
esac

echo -e "\n${COLOR_GREEN}✓ Brightness and Contrast adjusted successfully.${COLOR_RESET}"
