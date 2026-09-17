# 1of10 Ad Watchlist

Competitor ad review for 1of10: the longest-running live Meta ads for 9 tracked brands (vidIQ, OpusClip, Skool, Alex Hormozi, Canva, Adobe Video, Adobe, Slack, ClickFunnels), pulled from Foreplay on 2026-09-16, with a "Replicate first" set ranked by similarity to the 1of10 Video Editor.

Live site: https://1stdata.github.io/1of10-ad-watchlist/

## How to review

1. Type your name in the Reviewer box.
2. Watch each ad and press Approve or Deny. Add a note if you want.
3. Press "Copy link with my decisions" and send that link back; decisions load automatically when it is opened. "Download decisions CSV" exports the same thing.

Decisions save in your browser between visits and travel to others only through the link or the CSV.

## Files

- `index.html`: the site.
- `data/ads_index.csv` and `.json`: every ad with brand, rank, days running, format, CTA, hook, headline, primary text, transcript, landing URL, placements and Foreplay link.
- `data/<brand>/`: per-brand `ads.csv`, `cards.md` and `media_urls.txt`.
