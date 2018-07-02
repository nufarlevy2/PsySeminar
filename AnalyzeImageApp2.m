function varargout = AnalyzeImageApp2(varargin)
% ANALYZEIMAGEAPP2 MATLAB code for AnalyzeImageApp2.fig
%      ANALYZEIMAGEAPP2, by itself, creates a new ANALYZEIMAGEAPP2 or raises the existing
%      singleton*.
%
%      H = ANALYZEIMAGEAPP2 returns the handle to a new ANALYZEIMAGEAPP2 or the handle to
%      the existing singleton*.
%
%      ANALYZEIMAGEAPP2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZEIMAGEAPP2.M with the given input arguments.
%
%      ANALYZEIMAGEAPP2('Property','Value',...) creates a new ANALYZEIMAGEAPP2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalyzeImageApp2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalyzeImageApp2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalyzeImageApp2

% Last Modified by GUIDE v2.5 02-Jul-2018 21:32:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalyzeImageApp2_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalyzeImageApp2_OutputFcn, ...
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


% --- Executes just before AnalyzeImageApp2 is made visible.
function AnalyzeImageApp2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalyzeImageApp2 (see VARARGIN)

% Choose default command line output for AnalyzeImageApp2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalyzeImageApp2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AnalyzeImageApp2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% imagesListBoxHandler = findobj(0, 'tag', 'imagesListBox');
images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
setappdata(handles.imagesListBox,'images',images);
setappdata(handles.imagesListBox, 'ratNumList', getRatNumList(images,[],[],[]));
setappdata(handles.imagesListBox, 'sectionList', getSectionList(images,[],[],[]));
setappdata(handles.imagesListBox, 'dateList', getDateList(images,[],[],[]));
setappdata(handles.imagesListBox, 'currRatNum', 'All');
setappdata(handles.imagesListBox, 'currSection', 'All');
setappdata(handles.imagesListBox, 'currDate', 'All');
setappdata(handles.imagesListBox, 'currImage', 'All');



function imagesListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagesListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
disp('imagesListBox_CreateFcn');
images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
imagesListBoxHandler = findobj(0, 'tag', 'imagesListBox');
% images = getappdata(imagesListBoxHandler, 'images');
names = getImageList(images, [], [], []);
set(imagesListBoxHandler , 'string' ,names);

function imagesListBox_Callback(hObject, eventdata, handles)
% hObject    handle to retNumListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns retNumListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from retNumListBox

% --- Executes on button press in saveButton.
disp('imagesListBox_Callback');
selectedIndex = get(handles.imagesListBox,'Value'); 
currNames = get(handles.imagesListBox, 'string');
currImage = currNames(selectedIndex);
setappdata(handles.imagesListBox, 'currImage', currImage);

function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('saveButton_Callback');

% --- Executes on button press in getContrastedImage.
function getContrastedImage_Callback(hObject, eventdata, handles)
% hObject    handle to getContrastedImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('getContrastedImage_Callback');
names = get(handles.imagesListBox, 'string');
images = getappdata(handles.imagesListBox,'images');
nameFieldArray = {images(:).name};
currImage = getappdata(handles.imagesListBox, 'currImage');
if strcmp(currImage, 'All') && length(names) > 1
    for intI = 2: length(names)
        imageIndex = find(strcmp(nameFieldArray, names(intI)));
        BWPic = getContrastOfImage(images(imageIndex).fullPath, 0.1);
%         I = imread(images(imageIndex).fullPath);
        figure, imshow(BWPic), title(['Black And White Image: ',images(imageIndex).fullPath]);  
    end
else
    disp('only one folder');
    imageIndex = find(strcmp(nameFieldArray, currImage));
    I = imread(images(imageIndex).fullPath);
    figure, imshow(I), title(['original image: ',images(imageIndex).fullPath]);  
end

% --- Executes on button press in showOriginImage.
function showOriginImage_Callback(hObject, eventdata, handles)
% hObject    handle to showOriginImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('showOriginImage_Callback');
names = get(handles.imagesListBox, 'string');
images = getappdata(handles.imagesListBox,'images');
nameFieldArray = {images(:).name};
currImage = getappdata(handles.imagesListBox, 'currImage');
if strcmp(currImage, 'All') && length(names) > 1
    for intI = 2: length(names)
        imageIndex = find(strcmp(nameFieldArray, names(intI)));
        I = imread(images(imageIndex).fullPath);
        figure, imshow(I), title(['original image: ',images(imageIndex).fullPath]);  
    end
else
    disp('only one folder');
    imageIndex = find(strcmp(nameFieldArray, currImage));
    I = imread(images(imageIndex).fullPath);
    figure, imshow(I), title(['original image: ',images(imageIndex).fullPath]);  
end

% --- Executes on button press in getImageWithMarkedNuerons.
function getImageWithMarkedNuerons_Callback(hObject, eventdata, handles)
% hObject    handle to getImageWithMarkedNuerons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('getImageWithMarkedNuerons_Callback');

% --- Executes on button press in exportToExcel.
function exportToExcel_Callback(hObject, eventdata, handles)
% hObject    handle to exportToExcel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('exportToExcel_Callback');

% --- Executes on selection change in sectionListBox.
function sectionListBox_Callback(hObject, eventdata, handles)
% hObject    handle to sectionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sectionListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sectionListBox
disp('sectionListBox_Callback');
selectedIndex = get(handles.sectionListBox,'Value'); 
images = getappdata(handles.imagesListBox,'images');
sectionList = getappdata(handles.imagesListBox, 'sectionList');
currSection = sectionList(selectedIndex);
setappdata(handles.imagesListBox, 'currSection', currSection);
currDate = getappdata(handles.imagesListBox, 'currDate');
currRatNum = getappdata(handles.imagesListBox, 'currRatNum');
names = getImageList(images, currSection, currRatNum, currDate);
set(handles.imagesListBox , 'string' ,names);


% --- Executes during object creation, after setting all properties.
function sectionListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sectionListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
disp('sectionListBox_CreateFcn');
images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
sectionListBoxHandler = findobj(0, 'tag', 'sectionListBox');
sections = getSectionList(images, [], [], []);
set(sectionListBoxHandler , 'string' ,sections);


% --- Executes on selection change in retNumListBox.
function retNumListBox_Callback(hObject, eventdata, handles)
% hObject    handle to retNumListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns retNumListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from retNumListBox
disp('retNumListBox_Callback');
selectedIndex = get(handles.retNumListBox,'Value'); 
images = getappdata(handles.imagesListBox,'images');
ratNumList = getappdata(handles.imagesListBox, 'ratNumList');
currRatNum = ratNumList(selectedIndex);
setappdata(handles.imagesListBox, 'currRatNum', currRatNum);
currDate = getappdata(handles.imagesListBox, 'currDate');
currSection = getappdata(handles.imagesListBox, 'currSection');
names = getImageList(images, currSection, currRatNum, currDate);
set(handles.imagesListBox , 'string' ,names);

% --- Executes during object creation, after setting all properties.
function retNumListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to retNumListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
disp('retNumListBox_CreateFcn');
images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
ratNumListBoxHandler = findobj(0, 'tag', 'retNumListBox');
ratNums = getRatNumList(images, [], [], []);
set(ratNumListBoxHandler , 'string' ,ratNums);


% --- Executes on selection change in dateListBox.
function dateListBox_Callback(hObject, eventdata, handles)
% hObject    handle to dateListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dateListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dateListBox
disp('dateListBox_Callback');
selectedIndex = get(handles.dateListBox,'Value'); 
images = getappdata(handles.imagesListBox,'images');
dateList = getappdata(handles.imagesListBox, 'dateList');
currDate = dateList(selectedIndex);
setappdata(handles.imagesListBox, 'currDate', currDate);
currRatNum = getappdata(handles.imagesListBox, 'currRatNum');
currSection = getappdata(handles.imagesListBox, 'currSection');
names = getImageList(images, currSection, currRatNum, currDate);
set(handles.imagesListBox , 'string' ,names);

% --- Executes during object creation, after setting all properties.
function dateListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dateListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
disp('dateListBox_CreateFcn');
images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
dateListBoxHandler = findobj(0, 'tag', 'dateListBox');
dates = getDateList(images, [], [], []);
set(dateListBoxHandler , 'string' ,dates);


% --- Executes on slider movement.
function thresholdSlider_Callback(hObject, eventdata, handles)
% hObject    handle to thresholdSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function thresholdSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresholdSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
