#!/bin/bash

# --- Signal Trap ---
cleanup_on_interrupt() {
    echo -e "\n\n[!] Interrupt detected. Archiving..."
    if [ -d "$PARENT_DIR" ]; then
        tar -czf "${PARENT_DIR}_archive.tar.gz" "$PARENT_DIR"
        rm -rf "$PARENT_DIR"
        echo "[+] Saved to ${PARENT_DIR}_archive.tar.gz and cleaned up."
    fi
    exit 1
}
trap cleanup_on_interrupt SIGINT

# --- Setup ---
echo "--- Project Factory ---"
read -p "Enter project identifier: " USER_INPUT
PARENT_DIR="attendance_tracker_${USER_INPUT}"
mkdir -p "$PARENT_DIR/Helpers" "$PARENT_DIR/reports"

# --- File Generation ---
cat <<INNER_EOF > "$PARENT_DIR/attendance_checker.py"
print("Attendance Tracker Logic Initialized")
INNER_EOF

cat <<INNER_EOF > "$PARENT_DIR/Helpers/config.json"
{"warning_threshold": 75, "failure_threshold": 50}
INNER_EOF

cat <<INNER_EOF > "$PARENT_DIR/Helpers/assets.csv"
StudentID,Name,Score
101,Alice,88
INNER_EOF

touch "$PARENT_DIR/reports/reports.log"

# --- Sed Editing ---
echo "--- Configuration ---"
read -p "Update thresholds? (y/n): " UPDATE
if [[ "$UPDATE" == "y" ]]; then
    read -p "New Warning: " W
    read -p "New Failure: " F
    sed -i "s/\"warning_threshold\": [0-9]*/\"warning_threshold\": ${W:-75}/" "$PARENT_DIR/Helpers/config.json"
    sed -i "s/\"failure_threshold\": [0-9]*/\"failure_threshold\": ${F:-50}/" "$PARENT_DIR/Helpers/config.json"
fi

# --- Health Check ---
echo "--- Health Check ---"
if python3 --version > /dev/null 2>&1; then
    echo "[SUCCESS] python3 found: $(python3 --version)"
else
    echo "[WARNING] python3 not found."
fi
echo "Setup Complete!"
