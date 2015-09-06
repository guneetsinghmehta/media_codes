function[]=audio_cropper_gui()
%samples=[8625*Fs,8663*Fs];[y,Fs]=audioread('milkha.mp4',samples);
    defaultBackground = get(0,'defaultUicontrolBackgroundColor');
    roi_fig=figure('Name','Audio Clipper' );
    open_file_box=uicontrol('Parent',roi_fig,'Style','Pushbutton','Units','normalized','Position',[0.05 0.9 0.2 0.09],'String','Open File','Callback',@open_file_fn);
   % pause(5);
    filename_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.45 0.9 0.35 0.045],'String','Filename');
    
    fsin_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.05 0.8 0.15 0.09],'String','IP Sampling Frequency');
    fsin_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.22 0.8 0.13 0.09],'String','0 Hz');
    duration_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.45 0.8 0.19 0.09],'String','Duration');
    duration_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.65 0.8 0.15 0.09],'String','0 seconds');
    
    file_destination_box=uicontrol('Parent',roi_fig,'Style','Pushbutton','Units','normalized','Position',[0.05 0.7 0.2 0.09],'String','OP Destination','Callback',@op_destination_fn);
    output_file_box=uicontrol('Parent',roi_fig,'Style','text','Units','normalized','Position',[0.05 0.65 0.2 0.045],'String','Output File','Background',defaultBackground );
    
    fsop_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.05 0.6 0.15 0.045],'String','Fsout');
    fsop_box=uicontrol('Parent',roi_fig,'Style','edit','Units','normalized','Position',[0.2 0.6 0.15 0.045],'String','0','Background',[1 1 1],'Callback',@audio_main_fn);
    start_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.35 0.6 0.15 0.045],'String','Start');
    start_box=uicontrol('Parent',roi_fig,'Style','edit','Units','normalized','Position',[0.5 0.6 0.15 0.045],'String','0','Background',[1 1 1],'Callback',@audio_main_fn);
    end_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.65 0.6 0.15 0.045],'String','End');
    end_box=uicontrol('Parent',roi_fig,'Style','edit','Units','normalized','Position',[0.8 0.6 0.15 0.045],'String','0','Background',[1 1 1],'Callback',@audio_main_fn);
    
    title_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.05 0.5 0.15 0.09],'String','Title');
    title_box=uicontrol('Parent',roi_fig,'Style','edit','Units','normalized','Position',[0.2 0.5 0.15 0.09],'String','','Background',[1 1 1]);
    author_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.35 0.5 0.15 0.09],'String','Author');
    author_box=uicontrol('Parent',roi_fig,'Style','edit','Units','normalized','Position',[0.5 0.5 0.15 0.09],'String','','Background',[1 1 1]);
    comment_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.65 0.5 0.15 0.09],'String','Comment');
    comment_box=uicontrol('Parent',roi_fig,'Style','edit','Units','normalized','Position',[0.8 0.5 0.15 0.09],'String','','Background',[1 1 1]);
    
    output_format_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.05 0.4 0.45 0.045],'String','Output Format');
    output_format_box=uicontrol('Parent',roi_fig,'Style','popupmenu','Units','normalized','Position',[0.5 0.35 0.45 0.1],'String',{'.wav'});
    
    play_box=uicontrol('Parent',roi_fig,'Style','Pushbutton','Units','normalized','Position',[0.05 0.2 0.25 0.09],'String','Play','Callback',@play_fn);
    pause_box=uicontrol('Parent',roi_fig,'Style','Pushbutton','Units','normalized','Position',[0.31 0.2 0.25 0.09],'String','Pause','Callback',@pause_fn);
    resume_format_box=uicontrol('Parent',roi_fig,'Style','Pushbutton','Units','normalized','Position',[0.57 0.2 0.25 0.09],'String','Resume','Callback',@resume_fn);
    
    
    burn_box=uicontrol('Parent',roi_fig,'Style','Pushbutton','Units','normalized','Position',[0.05 0.05 0.3 0.05],'String','Burn','Callback',@burn_fn,'Background',[1 0 0]);
    
    %not checked

%     fsop_title_box=uicontrol('Parent',roi_fig,'Style','Text','Units','normalized','Position',[0.75 0.96 0.2 0.03],'String','OP Sampling Frequency');
%     fsop_box=uicontrol('Parent',roi_fig,'Style','Edit','Units','normalized','Position',[0.75 0.96 0.2 0.03],'String','0 Hz');
%     
%     output_format_title_box=uicontrol('Parent',roi_fig,'Style','text','Units','normalized','Position',[0.75 0.96 0.2 0.03],'String','Output Format');
%     
    global in_filename;
    global in_pathname;
    global audio;
    global op_pathname;
    global player;
    global fsin;
    global output;
    
    function[]=open_file_fn(object,handles)
        [in_filename,in_pathname,filterindex]=uigetfile({'*.mp3';'*.flv'},'Select audio','MultiSelect','off'); 
        [audio,fsin]=audioread([in_pathname in_filename]);
        set(fsin_box,'string',num2str(fsin));set(fsop_box,'string',num2str(fsin));
        set(filename_box,'string',in_filename);
        set(duration_box,'string',[num2str(floor(size(audio,1)/fsin)) ' sec']);
        set(end_box,'string',num2str(floor(size(audio,1)/fsin)));
        audio_main_fn2;
        display(get(object,'String'));
    end

    function[]=op_destination_fn(object,handles)
        [op_pathname]=uigetdir('Select Output folder'); 
        display(op_pathname);
    end

    function[]=audio_main_fn(object,handles)
        audio_main_fn2;
    end

    function[]=audio_main_fn2()
        A=audio;
        A_size=size(A,1);
        start_temp=str2num(get(start_box,'String'));end_temp=str2num(get(end_box,'String'));
        start=start_temp*fsin;
        if(start==0)
           start=1; 
        end
        ending=end_temp*fsin;
        
        Title=get(title_box,'String');
        Artist=get(author_box,'String');
        Comment=get(comment_box,'String');
        display(A_size);display(floor(start));display(floor(ending));pause(5);
        output=A(floor(start):floor(ending),:);
        size_out=size(output,1);
        Fs2=str2num(get(fsop_box,'String'));
        player=audioplayer(output,Fs2); 
        %player.play;
        
    end
 
    function[]=play_fn(object,handles)
       player.play; 
    end

    function[]=pause_fn(object,handles)
       player.pause; 
    end

    function[]=resume_fn(object,handles)
       player.resume; 
    end

    function[]=burn_fn(object,handles)
        Title=get(title_box,'String');
        Artist=get(author_box,'String');
        Comment=get(comment_box,'String');
        Fs2=str2num(get(fsop_box,'String'));
        output_filename=[op_pathname '\' in_filename '_modified.wav'];
        display(output_filename);
        audiowrite(output_filename,output,Fs2,'Title',Title,'Artist',Artist,'Comment',Comment);
    end
end