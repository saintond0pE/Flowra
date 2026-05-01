(function () {
  if (typeof window === "undefined" || typeof document === "undefined") return;

  var MIN_VISIBLE_MS = 550;
  var start = Date.now();
  var hidden = false;

  function hideLoader() {
    if (hidden) return;
    hidden = true;

    var overlay = document.getElementById("flowra-skeleton-overlay");
    if (!overlay) return;

    overlay.classList.add("flowra-skeleton-hide");
    setTimeout(function () {
      if (overlay && overlay.parentNode) overlay.parentNode.removeChild(overlay);
      document.documentElement.classList.remove("flowra-loading");
      document.documentElement.classList.add("flowra-loaded");
    }, 320);
  }

  function finalizeWhenReady() {
    var elapsed = Date.now() - start;
    var wait = Math.max(0, MIN_VISIBLE_MS - elapsed);
    setTimeout(hideLoader, wait);
  }

  function mountSkeleton() {
    if (document.getElementById("flowra-skeleton-overlay")) return;

    document.documentElement.classList.add("flowra-loading");

    var style = document.createElement("style");
    style.id = "flowra-skeleton-style";
    style.textContent = ""
      + "html.flowra-loading, html.flowra-loading body { overflow: hidden !important; }"
      + "#flowra-skeleton-overlay { position: fixed; inset: 0; z-index: 99999;"
      + "  background: linear-gradient(160deg, #fff2c2 0%, #ffd97a 48%, #ffc5a8 100%);"
      + "  display: flex; align-items: center; justify-content: center; transition: opacity .28s ease; }"
      + "#flowra-skeleton-overlay.flowra-skeleton-hide { opacity: 0; pointer-events: none; }"
      + "#flowra-skeleton-overlay .flowra-shell { width: min(1000px, 92vw);"
      + "  border: 4px solid #111; box-shadow: 10px 10px 0 #111; background: #fffef8; padding: 20px; }"
      + "#flowra-skeleton-overlay .flowra-top { height: 34px; width: 38%; margin-bottom: 18px; }"
      + "#flowra-skeleton-overlay .flowra-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 14px; }"
      + "#flowra-skeleton-overlay .flowra-card { height: 96px; }"
      + "#flowra-skeleton-overlay .flowra-line { height: 16px; margin-top: 12px; width: 88%; }"
      + "#flowra-skeleton-overlay .flowra-line.small { width: 62%; }"
      + "#flowra-skeleton-overlay .flowra-shimmer { border: 3px solid #111; background: #f7e9b8;"
      + "  position: relative; overflow: hidden; }"
      + "#flowra-skeleton-overlay .flowra-shimmer::after { content: ''; position: absolute; top: 0; left: -140%;"
      + "  width: 120%; height: 100%; background: linear-gradient(90deg, rgba(255,255,255,0), rgba(255,255,255,.65), rgba(255,255,255,0));"
      + "  animation: flowraShimmer 1.2s linear infinite; }"
      + "#flowra-skeleton-overlay .flowra-tag { margin-top: 14px; font: 800 11px/1 Inter, Arial, sans-serif; letter-spacing: .08em; color: #111; opacity: .7; }"
      + "@keyframes flowraShimmer { 100% { left: 130%; } }"
      + "@media (max-width: 760px) {"
      + "  #flowra-skeleton-overlay .flowra-shell { width: 94vw; padding: 14px; box-shadow: 6px 6px 0 #111; }"
      + "  #flowra-skeleton-overlay .flowra-grid { grid-template-columns: 1fr; gap: 10px; }"
      + "  #flowra-skeleton-overlay .flowra-card { height: 72px; }"
      + "}";

    var overlay = document.createElement("div");
    overlay.id = "flowra-skeleton-overlay";
    overlay.setAttribute("aria-hidden", "true");
    overlay.innerHTML = ""
      + '<div class="flowra-shell">'
      + '  <div class="flowra-top flowra-shimmer"></div>'
      + '  <div class="flowra-grid">'
      + '    <div class="flowra-card flowra-shimmer"></div>'
      + '    <div class="flowra-card flowra-shimmer"></div>'
      + '    <div class="flowra-card flowra-shimmer"></div>'
      + '  </div>'
      + '  <div class="flowra-line flowra-shimmer"></div>'
      + '  <div class="flowra-line small flowra-shimmer"></div>'
      + '  <div class="flowra-tag">FLOWRA SYSTEM LOADING...</div>'
      + '</div>';

    document.head.appendChild(style);
    document.body.appendChild(overlay);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", mountSkeleton, { once: true });
  } else {
    mountSkeleton();
  }

  if (document.readyState === "complete") {
    finalizeWhenReady();
  } else {
    window.addEventListener("load", finalizeWhenReady, { once: true });
    setTimeout(finalizeWhenReady, 3500);
  }
})();
