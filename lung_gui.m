function varargout = lung_gui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lung_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @lung_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before lung_gui is made visible.
function lung_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lung_gui (see VARARGIN)

% Choose default command line output for lung_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lung_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lung_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%reading and displaying the lungs pictres
clc
ID=input('Enter the Patient ID No:','s');
handles.ID=ID;
guidata(hObject, handles);
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

email=input('Enter the Patient Name:','s');
 handles.email=email;
guidata(hObject,handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;

temp=uigetfile('.jpg','input');
inimg = imread(temp);
inimg_gray = im2double(rgb2gray(inimg));
inimg_h = histeq(inimg_gray);
figure;imshow(inimg_h);title('Original Image with Histogram');
% create structure of handles
handles.inimg=inimg;
handles.img=inimg_h;
guidata(hObject, handles);
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;close all
patient_ID=handles.ID;
email=handles.email;
disp('Patient ID');
disp(patient_ID);
disp('------------');
disp('Patient Name');
disp(email)
inimg_h=handles.img;
inimg=handles.inimg;
size             =25;
nscale          =6;
norient         = 6;
minWaveLength   = 3;
mult            = 1.7;
sigmaOnf        = 0.65;
[gx]=loggabor(size,nscale,norient,minWaveLength,mult,sigmaOnf);
img_out_disp=imfilter(inimg_h,gx,'circular');
figure;imshow(img_out_disp);title('Median Filterd Enhanced Image')
%%%%%%%%%%%%%%%%%%%%%%%%%%
level = graythresh(img_out_disp);
BWs = im2bw(img_out_disp,level);
se90 = strel('line',3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('Gradient Mask');
BWnobord = imclearborder(BWsdil, 4);
figure, imshow(BWnobord), title(' Segmented Lung Nudle Image');
stats=regionprops(BWnobord,'area');
for i=1:length(stats)
   c{i}=stats(i).Area;
end
[B,L] =  bwboundaries(BWnobord,'noholes');
figure; imshow(inimg);title('possible location of cancer is traced by green boundary'); hold on;
total_area_lung=90000;
for k=1:length(c)
    if cell2mat(c(k))<500 && cell2mat(c(k))>50
        if cell2mat(c(k))>200 && cell2mat(c(k))<230
           disp('This disease is Stage 2') 
        else
            disp('This disease is Stage 1')
        end
        boundary = B{k};         
        disp('---------------------------------------------')
        disp('Area of the Cancer Nodule in mm^2');disp(c(k))       
        p(k)=(cell2mat(c(k))/total_area_lung)*100;
        disp('---------------------------------------------')
        disp('Cancer Nodule Percentage'),disp(p(k))
        plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
        
    
    end
end
