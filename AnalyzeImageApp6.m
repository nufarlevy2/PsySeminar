function varargout = AnalyzeImageApp6(varargin)
% ANALYZEIMAGEAPP6 MATLAB code for AnalyzeImageApp6.fig
%      ANALYZEIMAGEAPP6, by itself, creates a new ANALYZEIMAGEAPP6 or raises the existing
%      singleton*.
%
%      H = ANALYZEIMAGEAPP6 returns the handle to a new ANALYZEIMAGEAPP6 or the handle to
%      the existing singleton*.
%
%      ANALYZEIMAGEAPP6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZEIMAGEAPP6.M with the given input arguments.
%
%      ANALYZEIMAGEAPP6('Property','Value',...) creates a new ANALYZEIMAGEAPP6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalyzeImageApp6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalyzeImageApp6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalyzeImageApp6

% Last Modified by GUIDE v2.5 30-Jul-2018 19:30:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalyzeImageApp6_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalyzeImageApp6_OutputFcn, ...
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


% --- Executes just before AnalyzeImageApp6 is made visible.
function AnalyzeImageApp6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalyzeImageApp6 (see VARARGIN)

% Choose default command line output for AnalyzeImageApp6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalyzeImageApp6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AnalyzeImageApp6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% imagesListBoxHandler = findobj(0, 'tag', 'imagesListBox');
images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
setappdata(handles.imagesListBox,'images',images);
setappdata(handles.imagesListBox, 'ratNumList', getRatNumList(images,[],[],[], [], []));
setappdata(handles.imagesListBox, 'sectionList', getSectionList(images,[],[],[], [], []));
setappdata(handles.imagesListBox, 'dateList', getDateList(images,[],[],[], [], []));
setappdata(handles.imagesListBox, 'stainingList', getStainingList(images,[],[],[], [], []));
setappdata(handles.imagesListBox, 'magList', getMagList(images,[],[],[], [], []));
setappdata(handles.imagesListBox, 'currRatNum', 'All');
setappdata(handles.imagesListBox, 'currSection', 'All');
setappdata(handles.imagesListBox, 'currDate', 'All');
setappdata(handles.imagesListBox, 'currImage', 'All');
setappdata(handles.imagesListBox, 'currMag', 'All');
setappdata(handles.imagesListBox, 'currStaining', 'All');



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
names = getImageList(images, [], [], [], [], []);
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
threshold = get(handles.thresholdLabel, 'string');
if strcmp(currImage, 'All') && length(names) > 1
    for intI = 2: length(names)
        imageIndex = find(strcmp(nameFieldArray, names(intI)));
        BWPic = getContrastOfImage(images(imageIndex).fullPath, str2double(threshold));
        figure, imshow(BWPic), title(['Black And White Image: ',images(imageIndex).fullPath]);  
    end
else
    disp('only one folder');
    imageIndex = find(strcmp(nameFieldArray, currImage));
    BWPic = getContrastOfImage(images(imageIndex).fullPath, str2double(threshold));
    figure, imshow(BWPic), title(['Black And White Image: ',images(imageIndex).fullPath]);
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
images = getappdata(handles.imagesListBox, 'images');
currDate = getappdata(handles.imagesListBox, 'currDate');
currRatNum = getappdata(handles.imagesListBox, 'currRatNum');
currStaining = getappdata(handles.imagesListBox, 'currStaining');
currMag = getappdata(handles.imagesListBox, 'currMag');
currSection = getappdata(handles.imagesListBox, 'currSection');
pathes = getImageList(images, currSection, currRatNum, currDate, currMag, currStaining);
for pathIndex = 1: length(pathes)
%% continue with sending images to function and display them according to the table
end


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
currStaining = getappdata(handles.imagesListBox, 'currStaining');
currMag = getappdata(handles.imagesListBox, 'currMag');
names = getImageList(images, currSection, currRatNum, currDate, currMag, currStaining);
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
sections = getSectionList(images, [], [], [], [], []);
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
currStaining = getappdata(handles.imagesListBox, 'currStaining');
currMag = getappdata(handles.imagesListBox, 'currMag');
names = getImageList(images, currSection, currRatNum, currDate, currMag, currStaining);
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
ratNums = getRatNumList(images, [], [], [], [], []);
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
currStaining = getappdata(handles.imagesListBox, 'currStaining');
currMag = getappdata(handles.imagesListBox, 'currMag');
names = getImageList(images, currSection, currRatNum, currDate, currMag, currStaining);
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
dates = getDateList(images, [], [], [], [], []);
set(dateListBoxHandler , 'string' ,dates);


% --- Executes on slider movement.
function thresholdSlider_Callback(hObject, eventdata, handles)
% hObject    handle to thresholdSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
disp('thresholdSlider_Callback');
threshold =  get(hObject,'Value');
if threshold >= 0 || threshold <= 1
    set(handles.thresholdLabel, 'string', num2str(threshold));
end

% --- Executes during object creation, after setting all properties.
function thresholdSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresholdSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
disp('thresholdSlider_CreateFcn');
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
disp('thresholdSlider_CreateFcn');
set(hObject, 'Max', 1, 'Min', 0, 'SliderStep' , [1/100,1/100]);



function thresholdLabel_Callback(hObject, eventdata, handles)
% hObject    handle to thresholdLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresholdLabel as text
%        str2double(get(hObject,'String')) returns contents of thresholdLabel as a double
disp('thresholdLabel_Callback');

% --- Executes during object creation, after setting all properties.
function thresholdLabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresholdLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
disp('thresholdLabel_CreateFcn');
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'string', '0.1');


% --- Executes on slider movement.
function averagedCellSizeSlider_Callback(hObject, eventdata, handles)
% hObject    handle to averagedCellSizeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
disp('averagedCellSizeSlider_Callback');
averagedCellSize =  get(hObject,'Value');
if averagedCellSize > 0 || averagedCellSize <= 10
    set(handles.averagedCellSizeSlider, 'string', num2str(averagedCellSize));
end

% --- Executes during object creation, after setting all properties.
function averagedCellSizeSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to averagedCellSizeSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
disp('averagedCellSizeSlider_CreateFcn');
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Max', 5, 'Min', 0, 'SliderStep' , [1/100,1/100]);



function averagedCellSizeLabel_Callback(hObject, eventdata, handles)
% hObject    handle to averagedCellSizeLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of averagedCellSizeLabel as text
%        str2double(get(hObject,'String')) returns contents of averagedCellSizeLabel as a double
disp('averagedCellSizeLabel_Callback');

% --- Executes during object creation, after setting all properties.
function averagedCellSizeLabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to averagedCellSizeLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
disp('averagedCellSizeLabel_CreateFcn');
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject, 'string', '1');


% --- Executes on selection change in magnificationListBox.
function magnificationListBox_Callback(hObject, eventdata, handles)
% hObject    handle to magnificationListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns magnificationListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from magnificationListBox
disp('magnificationListBox_Callback');
selectedIndex = get(handles.magnificationListBox,'Value'); 
images = getappdata(handles.imagesListBox,'images');
magList = getappdata(handles.imagesListBox, 'magList');
currMag = magList(selectedIndex);
setappdata(handles.imagesListBox, 'currMag', currMag);
currSection = getappdata(handles.imagesListBox, 'currSection');
currStaining = getappdata(handles.imagesListBox, 'currStaining');
currDate = getappdata(handles.imagesListBox, 'currDate');
currRatNum = getappdata(handles.imagesListBox, 'currRatNum');
names = getImageList(images, currSection, currRatNum, currDate, currMag, currStaining);
set(handles.imagesListBox , 'string' ,names);

% --- Executes during object creation, after setting all properties.
function magnificationListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to magnificationListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
disp('magnificationListBox_CreateFcn');
images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
magnificationListBoxHandler = findobj(0, 'tag', 'magnificationListBox');
magList = getMagList(images, [], [], [], [], []);
set(magnificationListBoxHandler , 'string' ,magList);


% --- Executes on selection change in stainingListBox.
function stainingListBox_Callback(hObject, eventdata, handles)
% hObject    handle to stainingListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns stainingListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stainingListBox
disp('stainingListBox_Callback');
selectedIndex = get(handles.stainingListBox,'Value'); 
images = getappdata(handles.imagesListBox,'images');
stainingList = getappdata(handles.imagesListBox, 'stainingList');
currStaining = stainingList(selectedIndex);
setappdata(handles.imagesListBox, 'currStaining', currStaining);
currSection = getappdata(handles.imagesListBox, 'currSection');
currMag = getappdata(handles.imagesListBox, 'currMag');
currDate = getappdata(handles.imagesListBox, 'currDate');
currRatNum = getappdata(handles.imagesListBox, 'currRatNum');
names = getImageList(images, currSection, currRatNum, currDate, currMag, currStaining);
set(handles.imagesListBox , 'string' ,names);


% --- Executes during object creation, after setting all properties.
function stainingListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stainingListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
disp('stainingListBox_CreateFcn');
images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
stainingListBoxHandler = findobj(0, 'tag', 'stainingListBox');
stainingList = getStainingList(images, [], [], [], [], []);
set(stainingListBoxHandler , 'string' ,stainingList);


% --- Executes when entered data in editable cell(s) in sizesTable.
function sizesTable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to sizesTable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
disp('sizesTable_CellEditCallback');
tableValues = get(hObject, 'Data');
