---
title: VPN Guide
description: VPN setup and configuration guide for Servarr applications - When and how to use VPNs properly
published: true
date: 2025-01-07T00:00:00.000Z
tags: vpn, networking, docker, security, troubleshooting, gluetun
editor: markdown
dateCreated: 2025-01-07T00:00:00.000Z
---

# VPN Guide for Servarr Applications

## Table of Contents

- [Overview](#overview)
- [When VPNs are Needed](#when-vpns-are-needed)
- [Secure DNS Alternative (Recommended)](#secure-dns-alternative-recommended)
  - [Standard DNS Servers](#standard-dns-servers)
  - [DNS over HTTPS (DoH) and DNS over TLS (DoT)](#dns-over-https-doh-and-dns-over-tls-dot)
  - [Docker DNS Configuration](#docker-dns-configuration)
- [Why Gluetun is Usually NOT Needed](#why-gluetun-is-usually-not-needed)
- [Recommended Solutions](#recommended-solutions)
  - [Single Download Client](#single-download-client)
  - [Multiple Download Clients](#multiple-download-clients)
  - [Selective VPN (Prowlarr Indexers Only)](#selective-vpn-prowlarr-indexers-only)
- [VPN Provider Requirements](#vpn-provider-requirements)
- [Common Problems](#common-problems)
- [Troubleshooting](#troubleshooting)

## Overview

VPNs can cause significant problems with Servarr applications when used incorrectly. This guide explains when and how to use VPNs properly.

**Key Points**:

- **BitTorrent traffic** may benefit from VPN protection in some jurisdictions
- **Usenet traffic** does NOT require VPN protection (uses encrypted SSL connections)
- For most countries including the UK, using **secure DNS** is sufficient instead of VPNs and **fixes indexer connectivity issues**
- Only your **torrent client** should be behind a VPN - not the \*Arr applications
- VPNs are often unnecessary and cause more problems than they solve

> **To be clear it is not a matter if VPNs will cause issues with the \*Arr Apps, but when: image providers will block you and cloudflare is in front of most of \*Arr servers (updates, metadata, etc.) and liable to block you too**
{.is-warning}

## When VPNs are Needed

- **Highly Restrictive Countries**: China or Australia where internet access is heavily restricted
- **ISP Throttling**: If your ISP specifically throttles or blocks BitTorrent traffic
- **Legal Requirements**: If local laws require VPN use for P2P/BitTorrent activities

## Secure DNS Alternative (Recommended)

For most users, **secure DNS is sufficient instead of VPNs** and **fixes indexer connectivity issues** without the complexity and problems of VPN setups:

### Standard DNS Servers

- **Cloudflare**: `1.1.1.1` and `1.0.0.1`
- **Google**: `8.8.8.8` and `8.8.4.4`
- **Quad9**: `9.9.9.9` and `149.112.112.112`

### DNS over HTTPS (DoH) and DNS over TLS (DoT)

For enhanced privacy and encrypted DNS queries:

- **[Cloudflare DNS Setup](https://one.one.one.one/dns/)** - Instructions for DoH/DoT configuration
- **[Google Public DNS](https://developers.google.com/speed/public-dns/docs/secure-transports)** - DoH/DoT setup guide
- **[Quad9 Setup Instructions](https://quad9.net/service/service-addresses-and-features/)** - Configuration for various platforms

### Docker DNS Configuration

For Docker containers, see the [Docker DNS documentation](https://docs.docker.com/config/containers/container-networking/#dns-services) for configuration instructions.

> **Note**: These providers offer comprehensive setup instructions for browsers, operating systems, routers, and mobile devices.
{.is-info}

## Why Gluetun is Usually NOT Needed

Gluetun and similar VPN containers create more problems than they solve:

1. **Network Complexity**: Adds unnecessary routing complexity
2. **Container Dependencies**: Creates fragile dependencies
3. **Debugging Difficulty**: Makes troubleshooting much harder
4. **Performance Overhead**: Adds unnecessary overhead
5. **DNS Problems**: Often causes DNS resolution issues

## Recommended Solutions

### Single Download Client

Use download clients with built-in VPN support:

- **[Hotio qBittorrent](https://hotio.dev/containers/qbittorrent/)** - Built-in WireGuard VPN support
- **[Binhex VPN containers](https://github.com/binhex/)** - OpenVPN support (e.g., `binhex/arch-qbittorrentvpn`)

> **Important**: When using VPN containers, configure other containers to connect using the `.internal` domain suffix (e.g., `qbittorrent.internal` instead of just `qbittorrent`). This ensures reliable DNS resolution through Docker's built-in DNS, especially important with VPN routing. See the [Docker Guide](/docker-guide#using-internal-domain-for-container-communication) for more details.
{.is-warning}

### Multiple Download Clients

Use **[Hotio's base image](https://hotio.dev/containers/base/)** and route all download clients through it. This is the only acceptable use case for sharing a VPN container.

> **Important**: When routing multiple download clients through a VPN container, always use the `.internal` domain suffix for container communication (e.g., `sabnzbd.internal`, `qbittorrent.internal`). This provides reliable DNS resolution regardless of VPN routing complexity.
{.is-warning}

### Selective VPN (Prowlarr Indexers Only)

If specific indexers require VPN access, add your VPN provider's proxy to `Settings -> Indexers -> Indexer Proxies` and apply only to those specific indexers. This allows **only indexer traffic** to go through the VPN while keeping the main application free from VPN-related issues.

See the [TRaSH Guide for Prowlarr Proxy Setup](https://trash-guides.info/Prowlarr/prowlarr-setup-proxy/) for detailed configuration instructions.

## VPN Provider Requirements

For BitTorrent, you **must** use a VPN with port forwarding:

**Recommended (with port forwarding)**:

- TorGuard
- Private Internet Access (PIA)
- Proton VPN
- AirVPN

**Avoid (no port forwarding)**:

- Mullvad
- NordVPN
- Most commercial VPN services

See [TRaSH Guide for VPN setup](https://trash-guides.info/Misc/How-to-setup-Torguard-for-port-forwarding/).

## Common Problems

- **Rate Limiting/IP Bans**: VPN IPs are shared and often blocked
- **Private Tracker Bans**: Most private trackers ban VPN usage
- **DNS Issues**: Use public DNS servers (8.8.8.8, 1.1.1.1)
- **Service Accessibility**: Many services block VPN IP ranges

## Troubleshooting

**Debug Commands:**

```bash
# Check IP
curl ifconfig.me

# Test DNS
nslookup google.com

# Test container DNS resolution with .internal
nslookup qbittorrent.internal

# Container networking
docker network inspect <network_name>
```

**DNS Resolution Issues with VPN:**

If containers cannot communicate when using VPN:

1. Use `.internal` suffix for all container references (e.g., `qbittorrent.internal`)
2. Verify DNS configuration in VPN container
3. Check that containers are on the same Docker network
4. Test DNS resolution from within the container using the debug commands above

**When to Get Help:**

- [Sonarr Discord](https://discord.sonarr.tv/)
- [Radarr Discord](https://radarr.video/discord)
- [Lidarr Discord](https://lidarr.audio/discord)
- [Prowlarr Discord](https://prowlarr.com/discord)
- [TRaSH Discord](https://trash-guides.info/discord)

---

> **Remember**: The best VPN setup is often no VPN at all. Only use VPNs when you have specific requirements, and always prefer simple, tested solutions over complex setups.
{.is-success}
