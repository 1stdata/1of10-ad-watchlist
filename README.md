# 1of10 Ad Watchlist

Competitor creative review for 1of10's Meta ads: the top 15 longest-running live Meta ads for each of 9 tracked brands (vidIQ, OpusClip, Skool, Alex Hormozi, Canva DE, Adobe Video, Adobe, Slack, ClickFunnels), pulled from Foreplay Spyder on 2026-09-16, with the executive summary, cross-brand patterns and the creative brief for 1of10 at the top.

**Live site:** enable GitHub Pages on this repo (Settings, Pages, Deploy from branch `main`, folder `/ (root)`) and it serves `index.html`.

## How to review

1. Open the site and type your name in the Reviewer box.
2. Watch each ad (videos stream from Foreplay's CDN, one plays at a time) and press **Approve** or **Deny**. Add a note if you want.
3. Use the All / Approved / Denied / Pending filters to check your progress.
4. Press **Copy link with my decisions** and send that link back. Your decisions are encoded in the link and load automatically when it is opened. **Download decisions CSV** exports the same thing as a spreadsheet.

Decisions are saved in your browser between visits, but they only travel to someone else through the link or the CSV. Nothing is written back to this repo.

## What is in the repo

- `index.html`: the full review site, self-contained (fonts from Google Fonts, media streamed from Foreplay).
- `data/ads_index.csv` and `data/ads_index.json`: every ad with brand, rank, days running, format, CTA, hook, headline, primary text, transcript, landing URL, placements and Foreplay link.
- `data/all_media_urls.txt`: every video and image URL.
- `data/<brand>/`: per-brand `ads.csv`, `cards.md` (card-ready copy) and `media_urls.txt`.

## Notes on the data

Running duration is Foreplay's days-since-first-seen for ads still marked live in the Meta Ad Library; it is a proxy for a winner, not spend or performance. Transcripts are Foreplay's rough auto speech-to-text, reproduced as captured. Adobe Video's ads are music-only demos with no transcript. Frederik Frost is tracked but has no live Meta ads.
