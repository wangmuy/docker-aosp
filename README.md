AOSP based board building environment. Based on Ubuntu:16.04

Edit your build script and start with it:

```
echo "
cd /aosp && source build/envsetup.sh && lunch aosp_hammerhead-userdebug && make otapackage -j8
" > build.sh
chmod +x build.sh

docker run --rm -it -v $(pwd):/scripts -v /media/wf/android-6.0.0_r1/aosp:/aosp -v /media/wf/android-6.0.0_r1/ccache:/tmp/ccache wangmuy/aosp /scripts/start.sh $(pwd)/build.sh
```
