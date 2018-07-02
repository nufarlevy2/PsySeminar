function varargout = AnalyzeImageApp(varargin)
% ANALYZEIMAGEAPP MATLAB code for AnalyzeImageApp.fig
%      ANALYZEIMAGEAPP, by itself, creates a new ANALYZEIMAGEAPP or raises the existing
%      singleton*.
%
%      H = ANALYZEIMAGEAPP returns the handle to a new ANALYZEIMAGEAPP or the handle to
%      the existing singleton*.
%
%      ANALYZEIMAGEAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZEIMAGEAPP.M with the given input arguments.
%
%      ANALYZEIMAGEAPP('Property','Value',...) creates a new ANALYZEIMAGEAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalyzeImageApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalyzeImageApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalyzeImageApp

% Last Modified by GUIDE v2.5 02-Jul-2018 13:58:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalyzeImageApp_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalyzeImageApp_OutputFcn, ...
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


% --- Executes just before AnalyzeImageApp is made visible.
function AnalyzeImageApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalyzeImageApp (see VARARGIN)

% Choose default command line output for AnalyzeImageApp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalyzeImageApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);

images = extractFileInfoFromDataDir('C:\Users\levyn\Desktop\study\psySeminar\data');
imagesMat = cell2mat(images);
setappdata(handles.imagesListBox,'images','stam');

%Configurations:
NAME = 1;
FOLDER = 2;
DATE = 3;
BYTES = 4;
ISDIR = 5;
DATENUM = 6;
IS_PIC = 7;
IS_DAPI = 8;
IS_FOS = 9;
MYDATE = 10;
RET_NUM = 11;
MAGNIFICATION = 12;
FULL_PATH = 13;
SECTION = 14;
PIC_TYPE = 15;
% --- Outputs from this function are returned to the command line.
function varargout = AnalyzeImageApp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function imagesListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagesListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
images = getappdata(handles.imagesListBox, 'images');
set(handles.imagesListBox,'images',images(NAME));
guidata(hObject, handles);

% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in getContrastedImage.
function getContrastedImage_Callback(hObject, eventdata, handles)
% hObject    handle to getContrastedImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in showOriginImage.
function showOriginImage_Callback(hObject, eventdata, handles)
% hObject    handle to showOriginImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in getImageWithMarkedNuerons.
function getImageWithMarkedNuerons_Callback(hObject, eventdata, handles)
% hObject    handle to getImageWithMarkedNuerons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exportToExcel.
function exportToExcel_Callback(hObject, eventdata, handles)
% hObject    handle to exportToExcel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in sectionListBpx.
function sectionListBpx_Callback(hObject, eventdata, handles)
% hObject    handle to sectionListBpx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sectionListBpx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sectionListBpx


% --- Executes during object creation, after setting all properties.
function sectionListBpx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sectionListBpx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in retNumListBox.
function retNumListBox_Callback(hObject, eventdata, handles)
% hObject    handle to retNumListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns retNumListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from retNumListBox


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


% --- Executes on selection change in dateListBox.
function dateListBox_Callback(hObject, eventdata, handles)
% hObject    handle to dateListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dateListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dateListBox


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
