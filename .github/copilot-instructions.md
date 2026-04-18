# Project Guidelines

## Code Style
- **Stack**: Vanilla HTML5, Vanilla JavaScript, and Vanilla CSS3 + Tailwind CSS for layout routing. Avoid heavy frameworks and bloated dependencies.
- **Icons**: Use Material Symbols Outlined (Weight 700 / High Contrast).
- **Design System**: Consult [`FLOWRA_DESIGN_PROMPT.md`](../FLOWRA_DESIGN_PROMPT.md) for strict "Warm Pastel Neo-Brutalist" design tokens, including exact hex codes, hard zero-blur black box shadows, and 4px structural borders.

## Architecture
- **Structure**: Completely static file architecture, ready for immediate CDN deployment.
- **Paths**: Keep index routing minimal; main pages reside in the `/pages` directory, and the global stylesheet is `styles.css`.

## Build and Test
- **Local Dev Server**: Requires Python to spin up.
  ```bash
  python -m http.server 8000
  ```
- Access at `http://localhost:8000`.

## Conventions
- **Neo-Brutalist Kineticism**: Follow the "Kinetic Manifesto" outlined in the [`README.md`](../README.md). New interactive elements must integrate thick (4px-12px) block shadows, high-contrast borders, and kinetic micro-animations (e.g., pulse effects on workflows, bouncing dot algorithms for chatbots).
