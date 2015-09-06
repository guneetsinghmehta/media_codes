player=audioplayer(audio,44100);
player.play;
% for i=1:obj.NumberOfFrames
%     imshow(video(:,:,:,i));
%     pause(0.4/obj.FrameRate);
% end
implay(video,obj.FrameRate);