//
// Created by Marc Rousavy on 05.05.23.
//

#include "SkiaPreviewView.h"

#include <android/log.h>

namespace vision {

using TSelf = jni::local_ref<SkiaPreviewView::jhybriddata>;

TSelf SkiaPreviewView::initHybrid(jni::alias_ref<jhybridobject> jThis) {
    return makeCxxInstance(jThis);
}

void SkiaPreviewView::registerNatives() {
    registerHybrid({
       makeNativeMethod("initHybrid", SkiaPreviewView::initHybrid),
       makeNativeMethod("onSurfaceTextureAvailable", SkiaPreviewView::onSurfaceTextureAvailable),
       makeNativeMethod("onSurfaceTextureSizeChanged", SkiaPreviewView::onSurfaceTextureSizeChanged),
       makeNativeMethod("onSurfaceTextureDestroyed", SkiaPreviewView::onSurfaceTextureDestroyed),
       makeNativeMethod("onSurfaceTextureUpdated", SkiaPreviewView::onSurfaceTextureUpdated),
    });
}

void SkiaPreviewView::onSurfaceTextureAvailable(const facebook::jni::alias_ref<jobject> &surface,
                                                jint width, jint height) {
    __android_log_write(ANDROID_LOG_INFO, TAG,
                        "onSurfaceTextureAvailable!");
}

void SkiaPreviewView::onSurfaceTextureSizeChanged(const facebook::jni::alias_ref<jobject> &surface,
                                                jint width, jint height) {
    __android_log_write(ANDROID_LOG_INFO, TAG,
                        "onSurfaceTextureSizeChanged!");
}

jboolean SkiaPreviewView::onSurfaceTextureDestroyed(const facebook::jni::alias_ref<jobject> &surface) {
    __android_log_write(ANDROID_LOG_INFO, TAG,
                        "onSurfaceTextureDestroyed!");
    return false;
}

void SkiaPreviewView::onSurfaceTextureUpdated(const facebook::jni::alias_ref<jobject> &surface) {
    __android_log_write(ANDROID_LOG_INFO, TAG,
                        "onSurfaceTextureUpdated!");
}

} // namespace vision