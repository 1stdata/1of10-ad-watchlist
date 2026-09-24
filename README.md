# 1of10 Ad Watchlist

Competitor ad review for 1of10: the longest-running live Meta ads for 25 brands (vidIQ, OpusClip, Skool, Alex Hormozi, Canva, Adobe Video, Adobe, Slack, ClickFunnels, plus Descript, CapCut, VEED, InVideo, Filmora, Ableton, Splice, Native Instruments, HubSpot, Hootsuite, Northbeam, AG1, Momentous, Thorne, Transparent Labs, Seed), pulled from Foreplay on 2026-09-16 and 2026-09-17, with a "Replicate first" set ranked by similarity to the 1of10 Video Editor.

Live site: https://1stdata.github.io/1of10-ad-watchlist/

## How to review

1. Type your name in the Reviewer box.
2. Watch each ad and press Approve or Deny. Add a note if you want.
3. Press "Copy link with my decisions" and send that link back; decisions load automatically when it is opened. "Download decisions CSV" exports the same thing.

Decisions save in your browser between visits and travel to others only through the link or the CSV.

## Files

- `index.html`: the video watchlist.
- `scripts.html`: Brent's approved ads rewritten beat by beat for the AI Video Editor and the AI Thumbnail Generator, with shooting notes. Anyone with the link can comment and reply (name typed once). Only the owner, after signing in with a passphrase on the page, can edit the rewrites and mark comments approved or done; the passphrase is checked by the database, never by the page. Data lives in the Supabase project 1of10-ad-watchlist (tables and functions in `supabase_setup.sql`; the page reads the project URL and publishable key from the `CFG` line near the end of the file).
- `statics.html`: the static (image and carousel) watchlist, with a "Statics to test" set ranked the same way. Pulled 2026-09-17.
- `data/statics_index.csv` and `.json`: every static ad with brand, rank, days running, format, CTA, headline, primary text, card text, landing URL, image URLs and Foreplay link.
- `data/ads_index.csv` and `.json`: every ad with brand, rank, days running, format, CTA, hook, headline, primary text, transcript, landing URL, placements and Foreplay link.
- `data/<brand>/`: per-brand `ads.csv`, `cards.md` and `media_urls.txt`.

## Brands that could not be added

Gling, Palmier and DaVinci Resolve have no Foreplay brand page. Higgsfield, Buffer, Think Media and Sean Cannell have no live Meta ads (Think Media and Sean Cannell only have TikTok posts indexed). Logic Pro and FL Studio have no ad pages. Not in Foreplay means not in the Meta Ad Library as a tracked advertiser.
