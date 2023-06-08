import type { CameraCaptureError } from './CameraError';
import type { TemporaryFile } from './TemporaryFile';

export type VideoFileType = 'mov' | 'avci' | 'm4v' | 'mp4';

export type CameraVideoCodec =
  | 'h264'
  | 'hevc'
  | 'hevc-alpha'
  | 'jpeg'
  | 'pro-res-4444'
  | 'pro-res-422'
  | 'pro-res-422-hq'
  | 'pro-res-422-lt'
  | 'pro-res-422-proxy';

export interface RecordingSessionOptions {
  /**
   * Sets the file type to use for the Video Recording.
   * @default "mov"
   */
  fileType?: VideoFileType;
  /**
   * Set the video codec to record in. Different video codecs affect video quality and video size.
   * To get a list of all available video codecs use the `getAvailableVideoCodecs()` function.
   *
   * @default undefined
   * @platform iOS
   */
  videoCodec?: CameraVideoCodec;
}

export interface RecordVideoOptions extends RecordingSessionOptions {
  /**
   * Set the video flash mode. Natively, this just enables the torch while recording.
   */
  flash?: 'on' | 'off' | 'auto';
  /**
   * Called when there was an unexpected runtime error while recording the video.
   */
  onRecordingError: (error: CameraCaptureError) => void;
  /**
   * Called when the recording has been successfully saved to file.
   */
  onRecordingFinished: (video: VideoFile) => void;
}

/**
 * Represents a Video taken by the Camera written to the local filesystem.
 *
 * Related: {@linkcode Camera.startRecording | Camera.startRecording()}, {@linkcode Camera.stopRecording | Camera.stopRecording()}
 */
export interface VideoFile extends TemporaryFile {
  /**
   * Represents the duration of the video, in seconds.
   */
  duration: number;
}
