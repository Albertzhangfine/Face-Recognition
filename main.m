clear 
clc
%% load video
video =VideoReader('Example.mp4');
numFrames = video.NumFrames;
%% obtain the size of video
frame = read(video,1);
frameSize = size(frame);
%% create a video player
videoPlayer  = vision.VideoPlayer('Position',[200 100 fliplr(frameSize(1:2)+30)]);
faceDetector = vision.CascadeObjectDetector(); % Finds faces by default
%% recognize faces in the video frame by frame
frameNumber = 0;
keepRunning = true;
disp('Press Ctrl-C to exit below');
for i=1:numFrames
        framergb = read(video,i);
        frame = rgb2gray(framergb);
        % recognize face
        % below : shrink the video to speed up the program
        % bboxes = faceDetector.step(frame);
        bboxes = 2 * faceDetector.step(imresize(frame, 0.5));
        if ~isempty(bboxes)
            displayFrame = insertObjectAnnotation(framergb, 'rectangle',...
            bboxes(1,:), 'face');
            videoPlayer.step(displayFrame);
        end
end
%% close video player
release(videoPlayer);
