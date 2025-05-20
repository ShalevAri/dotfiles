### MPVYT ###
# mpvyt is a custom version (simply an alias) that runs the `mpv` command with some custom
# flags to make it work better when viewing YouTube videos

function mpvyt
    if test (count $argv) -eq 0
        echo "Usage: mpvyt <video_url_or_file> [additional mpv options]"
        return 1
    end

    # Extract the first argument as the video URL or file
    set video $argv[1]

    # Shift the arguments to pass any additional flags to mpv
    set extra_args $argv[2..-1]

    # Optimized mpv command with additional arguments
    mpv --hwdec=auto --scale=ewa_lanczos --cscale=ewa_lanczos \
        --video-sync=display-resample --interpolation --tscale=box $extra_args $video
end
