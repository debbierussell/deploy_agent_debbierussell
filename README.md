# Automated Project Bootstrapping Agent

This project is an Infrastructure as Code (IaC) solution designed to automate the deployment of a Student Attendance Tracker workspace. It ensures environment reproducibility and handles process interrupts gracefully.

Prerequisites
* Linux/Unix environment (bash)
* Python 3 installed

How to Run the Script
1. Set Permissions: Ensure the script is executable:
   ```bash
   chmod +x setup_project.sh
   ```
2. Execute: Run the script from your terminal:
   ```bash
   ./setup_project.sh
   ```
3. Follow Prompts: Enter your project identifier and choose whether to update the attendance thresholds via the interactive prompt.

Features
Dynamic Configuration
The script uses `sed` to perform in-place editing of the `config.json` file based on your input for Warning and Failure thresholds.

Signal Trap (Archive Feature)
The script includes a built-in safety mechanism to handle user interrupts (SIGINT/Ctrl+C). 

To trigger the archive feature:
1. Start the script: `./setup_project.sh`
2. When prompted for an input, press **Ctrl+C**.
3. The script will automatically:
   * Catch the interrupt signal.
   * Bundle the current workspace into a `.tar.gz` archive.
   * Delete the incomplete directory to keep the workspace clean.

Health Check
Before completion, the script verifies the system's Python 3 installation to ensure the environment is ready for the application logic.

Video Walkthrough
