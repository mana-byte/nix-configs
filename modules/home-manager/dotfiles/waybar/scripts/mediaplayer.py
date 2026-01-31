#!/usr/bin/env python3
import subprocess
import json

def get_mpd_info():
    try:
        status = subprocess.check_output(["mpc", "status"]).decode("utf-8").split('\n')
        if len(status) >= 2 and "[playing]" in status[1]:
            title_line = status[0]
            artist_title = title_line.split(" - ", 1)
            if len(artist_title) == 2:
                artist, title = artist_title
            else:
                artist, title = "", artist_title[0]
            output = {
                "text": f" {artist} - {title}",
                "tooltip": f"{artist} - {title}",
                "class": "mpd",
                "alt": "mpd"
            }
        else:
            output = {
                "text": " Stopped",
                "tooltip": "MPD is not playing",
                "class": "stopped",
                "alt": "stopped"
            }
        print(json.dumps(output))
    except Exception:
        print(json.dumps({
            "text": " Error",
            "tooltip": "Could not get MPD status",
            "class": "error",
            "alt": "error"
        }))

get_mpd_info()
