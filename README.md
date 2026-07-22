# 🛡️ vsec - Server Security Dashboard & Monitoring CLI

`vsec` is a lightweight, zero-dependency bash and Python utility for Linux servers (Debian/Ubuntu) that aggregates system security posture, network isolation, firewall state, active sessions, and brute-force intrusion metrics into an instant CLI dashboard or structured JSON payload.

---

## 📁 Repository Structure

```text
.
├── README.md       # Project documentation
├── install.sh      # System-wide installation script
└── bin/
    └── vsec        # Dashboard binary payload
```

---

## 🚀 Quick Installation

Install `vsec` system-wide to `/usr/local/bin/vsec` using a single command:

### Option 1: Remote Installer Script (`curl | sudo bash`)

```bash
curl -fsSL https://raw.githubusercontent.com/notasandworm/vsec/main/install.sh | sudo bash
```

### Option 2: Direct Binary Download (`curl -o`)

```bash
sudo curl -fsSL https://raw.githubusercontent.com/notasandworm/vsec/main/bin/vsec -o /usr/local/bin/vsec && sudo chmod +x /usr/local/bin/vsec
```

### Option 3: Local Repository Clone

```bash
git clone https://github.com/notasandworm/vsec.git
cd vsec
sudo ./install.sh
```

---

## 💻 Usage

`vsec` requires `sudo` / root privileges to inspect `journalctl` logs, query UFW rules, and scan active listening sockets.

```bash
# Terminal Dashboard (Colorized output)
sudo vsec

# Structured JSON Output (For programmatic monitoring & API endpoints)
sudo vsec --json

# Display Help & Usage
sudo vsec --help
```

---

## 📊 Security Dashboard Sections

When executed, `vsec` collects and displays 9 core security modules:

1. **UFW Firewall Status**: Checks if UFW is active and lists configured rules.
2. **Tailscale Network Mesh**: Reports Tailscale daemon state, IPv4/IPv6 mesh address, and connected peers.
3. **Cloudflare Tunnels**: Checks `cloudflared` daemon status and active tunnels.
4. **Docker Container Isolation**: Scans active Docker containers, running statuses, and mapped host ports.
5. **Fail2ban Jail Activity**: Dynamically lists active jails, currently banned IPs, and total banned counts.
6. **SSH Security & Daemon Activity**: Detects failed password attempts in the last 24h via `journalctl` and displays recent SSH log entries.
7. **Journald System Storage**: Verifies if system logs are persistent (`/var/log/journal`) or volatile (`/run/log/journal`).
8. **Non-Localhost Listening Sockets**: Scans active TCP/UDP ports bound to non-localhost interfaces (`ss -tulpn`).
9. **Logged-in Sessions**: Lists active user logins, TTY sessions, and remote IP origins (`who`).
