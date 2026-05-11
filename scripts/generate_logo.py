#!/usr/bin/env python3
"""Generate cybersynth_logo.svg with synthwave neon text and perspective grid."""

import random
import math

random.seed(42)

W, H = 1200, 630
HORIZON = 420
VANISH = (W // 2, HORIZON)

# Colors from lua/cybersynth/palette.lua (dark variant)
DEEP = "#0d0d1a"
ALT_BG = "#241b2f"
PINK = "#ff2d78"
MAGENTA = "#ff7edb"
CYAN = "#36f9f6"
YELLOW = "#fede5d"
AMBER = "#ffb86c"


def star_field(n=120):
    """Generate random white stars in the upper sky."""
    stars = []
    for _ in range(n):
        x = random.randint(0, W)
        y = random.randint(0, HORIZON - 20)
        r = random.uniform(0.3, 1.5)
        o = random.uniform(0.2, 0.8)
        stars.append(
            f'<circle cx="{x}" cy="{y}" r="{r:.1f}" fill="white" opacity="{o:.2f}"/>'
        )
    return "\n    ".join(stars)


def horizontal_grid_lines(n=20):
    """Generate exponentially spaced horizontal grid lines below the horizon."""
    lines = []
    for i in range(1, n + 1):
        t = i / n
        # Exponential spacing — closer together near horizon
        y = HORIZON + (H - HORIZON) * (t ** 2)
        lines.append(
            f'<line x1="0" y1="{y:.1f}" x2="{W}" y2="{y:.1f}" '
            f'stroke="{CYAN}" stroke-width="1.5" opacity="0.6"/>'
        )
    return "\n    ".join(lines)


def vertical_grid_lines(n=32):
    """Generate vertical grid lines converging at the vanishing point."""
    lines = []
    half = n // 2
    for i in range(-half, half + 1):
        if i == 0:
            continue
        angle = math.radians(i * 3.5)  # fan out ~3.5° per line
        # Extend line from vanishing point to bottom edge
        dy = H - HORIZON
        dx = math.tan(angle) * dy
        x_end = VANISH[0] + dx
        lines.append(
            f'<line x1="{VANISH[0]:.1f}" y1="{VANISH[1]:.1f}" '
            f'x2="{x_end:.1f}" y2="{H}" '
            f'stroke="{CYAN}" stroke-width="1.5" opacity="0.5"/>'
        )
    return "\n    ".join(lines)


def make_svg():
    return f'''<?xml version="1.0" encoding="UTF-8"?>
<svg width="{W}" height="{H}" viewBox="0 0 {W} {H}" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <!-- Sky gradient -->
    <linearGradient id="sky" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="{DEEP}"/>
      <stop offset="45%" stop-color="{ALT_BG}"/>
      <stop offset="80%" stop-color="{PINK}" stop-opacity="0.9"/>
      <stop offset="100%" stop-color="{MAGENTA}" stop-opacity="0.7"/>
    </linearGradient>

    <!-- Sun radial gradient -->
    <radialGradient id="sunGrad" cx="50%" cy="50%" r="50%">
      <stop offset="0%" stop-color="{YELLOW}"/>
      <stop offset="55%" stop-color="{AMBER}"/>
      <stop offset="100%" stop-color="{PINK}" stop-opacity="0.2"/>
    </radialGradient>

    <!-- Glow filters -->
    <filter id="glow-cyan" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="10" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>

    <filter id="glow-magenta" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="5" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>

    <filter id="sun-glow" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="25" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <!-- Sky background -->
  <rect width="{W}" height="{H}" fill="url(#sky)"/>

  <!-- Stars -->
  <g id="stars">
    {star_field()}
  </g>

  <!-- Sun (centered, sitting on horizon) -->
  <circle cx="600" cy="300" r="180" fill="url(#sunGrad)" filter="url(#sun-glow)"/>

  <!-- Grid floor -->
  <g id="grid">
    {horizontal_grid_lines()}
    {vertical_grid_lines()}
  </g>

  <!-- Horizon glow line -->
  <line x1="0" y1="{HORIZON}" x2="{W}" y2="{HORIZON}" stroke="{CYAN}" stroke-width="4" filter="url(#glow-cyan)"/>

  <!-- Neon text: CYBERSYNTH -->
  <g id="text" text-anchor="middle" dominant-baseline="central">
    <!-- Outer cyan stroke with heavy glow -->
    <text x="600" y="380"
          font-family="Impact, 'Arial Black', 'Helvetica Neue', sans-serif"
          font-size="165" font-weight="900"
          letter-spacing="8"
          fill="none" stroke="{CYAN}" stroke-width="14"
          filter="url(#glow-cyan)">CYBERSYNTH</text>

    <!-- Inner magenta stroke with lighter glow -->
    <text x="600" y="380"
          font-family="Impact, 'Arial Black', 'Helvetica Neue', sans-serif"
          font-size="165" font-weight="900"
          letter-spacing="8"
          fill="none" stroke="{MAGENTA}" stroke-width="7"
          filter="url(#glow-magenta)">CYBERSYNTH</text>
  </g>
</svg>
'''


if __name__ == "__main__":
    svg_content = make_svg()
    with open("assets/cybersynth_logo.svg", "w", encoding="utf-8") as f:
        f.write(svg_content)
    print("Generated assets/cybersynth_logo.svg")
