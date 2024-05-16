

*Ever heard of ffmpeg?*

- Here is bash script to generate a timelapse video from a video source. it uses the ffmpeg cli tool



### run
- first make sure you have ffmpeg installed. 
- then run:
```bash
	#run on linux
	cd timelapse-generator
	sudo bash ./generate_timelapse.sh ~/path/to/destination/folder ~/path/to/video/source
```

- you can change how many frames per second on generation by changing the -r 1 attribute to -r <any number of frames>. Note that the higher the frames the slower the timelapse 
```bash
# adjust frames per second as needed, example
ffmpeg -i "$filename" -r 10 -f image2 "$temp_dir/%05d.png"
```
- the generated video will now be at 10 fps and less speedy on play
