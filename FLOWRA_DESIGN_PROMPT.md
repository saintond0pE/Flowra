# Flowra Design System & Gen-AI Prompts

This document contains the exact terminology and prompt templates needed to generate matching marketing assets, PDF banners, and brochures for Flowra.

## Official Style Name
**"Warm Pastel Neo-Brutalism"** or **"Kinetic Pastel Constructivism"**

This specific intersection of aesthetics marries the aggressive, uncompromising grid structures of raw Brutalism with the highly approachable, warm softness of creamy backgrounds and candy-colored pastels. 

---

## The Core Design Tokens

If you are communicating with human designers, use these exact tokens to maintain consistency:

### 1. Color Palette
- **The Canvas (Background):** Warm Cream (`#FFF9E6`) — *replaces standard stark white.*
- **The Structure (Borders/Shadows):** Absolute Black (`#000000`).
- **Primary Accent 1:** Lavender Lilac (`#B19CD9`).
- **Primary Accent 2:** Coral Melon (`#FF8A65`).
- **Primary Accent 3:** Electric Sky Blue (`#38BDF8`).

### 2. Structural Elements
- **Borders:** Hard, continuous 2px to 4px black strokes.
- **Shadows:** Solid black blocks with absolutely **zero blur**. Typically offset diagonally by 4px to 8px (e.g., `box-shadow: 6px 6px 0px 0px #000000`).
- **Typography:** Heavyweight (Black/900), sans-serif (e.g., Inter), almost always uppercase with tight letter spacing (tracking). 

---

## Gen-AI Prompt Library
Copy and paste these prompts into Midjourney, DALL-E, Canva Magic Media, or other AI image tools to generate complementary graphics.

### Prompt 1: For PDF Banner Backgrounds & Illustrations
> **Copy/Paste:** A vector illustration in a Warm Pastel Neo-Brutalist style. The background is a soft, warm cream color. Features bold, thick, absolute black outlines and hard, unblurred solid black block shadows. The interior fill colors are strictly limited to highly saturated but soft pastels: lavender lilac, coral melon, and electric sky blue. Flat design, 2D, kinetic typography elements, geometric grids, modular UI components, tech-forward but highly approachable, minimalist composition, clean vector art. --ar 16:9

### Prompt 2: For Brochure Covers / Hero Assets
> **Copy/Paste:** A magazine cover design utilizing Kinetic Pastel Constructivism. Heavy, aggressive uppercase sans-serif typography tightly kerned. Thick black structural borders diving the layout into a strict asymmetrical grid. The negative space is a warm off-white cream tone. Feature bold graphical shapes colored exclusively in electric sky blue, warm coral pastel, and soft lavender. Hard zero-blur black drop shadows underneath elements. High contrast, B2B SaaS aesthetic, premium automation tool aesthetic, brutalist Dribbble UI trend. --ar 3:4

### Prompt 3: For Spot Graphics & Icons
> **Copy/Paste:** A single iconography set element for a SaaS landing page, designed in striking Pastel Neo-Brutalism. Depict [INSERT OBJECT, e.g., a lightning bolt and a gear]. It must have a thick 4px solid black outline, filled with warm coral pastel (`#FF8A65`) and lavender (`#B19CD9`). It sits on a warm cream background and casts a hard, offset, unblurred solid black 6px shadow to the bottom right. Clean, sharp, flat vector style. --ar 1:1

---

## AI Image Generation Tips:
- **Keyword Weights:** If an AI model leans too "3D", append the phrase `flat color, strictly 2D vector, no gradients` to force it back to Neo-Brutalism.
- **Text Generation:** Gen-AI struggles with correct spelling. When rendering banners, generate the *blank backgrounds and assets* using these prompts, then overlay your actual text perfectly sized in Canva or Figma.
