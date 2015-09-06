function [ player,output] = video_cropper( input_args )
% step 1 = open a uigetfile 
% step 2 = read the file as audio and also the sampling rate
% step 3 = enter two values - start and stop time for cropping - in code
% step 4 = enter the sampling rate and save the output formate
% step 5 = save the file as a new song
% step 6 = give option of changing the Fs while playing
%
    [filename,pathname,filterindex]=uigetfile({'*.mp3';'*.flv'},'Select Video','MultiSelect','off'); 
    obj=VideoReader([pathname filename]);
    obj.play;
%     A_size=size(A,1);
%     start=0.8*A_size;ending=0.9*A_size;Fs2=Fs;
%     Title='abc';Artist='GSM';Comment='PJ';
%     output=A(floor(start):floor(ending),:);
%     
%     
%     size_out=size(output,1);
%     display(size_out);%pause(5);
%     
%     
%     player=audioplayer(output,Fs2);
%    % player.play;
%     audiowrite('never_modified2.wav',output,Fs2,'Title',Title,'Artist',Artist,'Comment',Comment);
%     
end

