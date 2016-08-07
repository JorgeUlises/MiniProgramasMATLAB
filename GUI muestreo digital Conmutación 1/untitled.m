function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 19-Mar-2015 10:54:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
clear all;

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)
% hObject    handle to grabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global duracion fs senal_grabada bits grabada indice2
grabada = 0;
d1 = get(handles.duracion, 'string');
f1 = get(handles.frecuencia, 'string');
set(handles.duracion, 'backgroundcolor', 'white');
set(handles.frecuencia, 'backgroundcolor', 'white');
%
%pause(3);
if isempty(d1) | isempty(f1)
    warndlg('Alguno de los parámetros no está configurado o se encuentra vacío. Por favor ingrese valores para la Frecuencia y el Tiempo.');
    set(handles.duracion, 'backgroundcolor', 'red');
    set(handles.frecuencia, 'backgroundcolor', 'red');
else
duracion = str2double(d1);
valido = 1;
if (duracion <= 0)
    valido = 0;
    warndlg('El tiempo de la grabación no puede ser negativa o cero','Advertencia');
    set(handles.duracion, 'backgroundcolor', 'red');
end
if (duracion ~= fix(duracion))
    valido = 0;
    warndlg('El tiempo de la grabación debe ser un número entero ','Advertencia');
    set(handles.duracion, 'backgroundcolor', 'red');
end
fs = str2double(f1);
if (fs < 8000 | fs > 96000)
    valido = 0;
    warndlg('La frecuencia debe estar entre 8000 y 96000 Hz','Advertencia');
    set(handles.frecuencia, 'backgroundcolor', 'red');
end
if (fs ~= fix(fs))
    valido = 0;
    warndlg('La frecuencia no es un número entero','Advertencia');
    set(handles.frecuencia, 'backgroundcolor', 'red');
end
if valido
waitfor(warndlg('Su grabación comenzará cuando cierre el diálogo.','Alerta de grabación de audio'));
senal_salida=audiorecorder(fs,24,1);
recordblocking(senal_salida,duracion);
senal_grabada=getaudiodata(senal_salida, 'single');
set(handles.archivocargado,'string','Señal grabada...');
y = fft(senal_grabada);
warndlg('Se ha terminado de grabar','Grabación terminada');
grabada = 1;
end
end




% --- Executes on selection change in audio.
function audio_Callback(hObject, eventdata, handles)
% hObject    handle to audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns audio contents as cell array
%        contents{get(hObject,'Value')} returns selected item from audio


% --- Executes on button press in graficar1.
function graficar1_Callback(hObject, eventdata, handles)
% hObject    handle to graficar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global repro
indice1 = get(handles.popupmenu1, 'value');
if indice1 == 1,
repro = wavread('uno.wav');
end
if indice1 == 2,
repro = wavread('dos.wav');
end
if indice1 == 3,
repro = wavread('tres.wav');
end
if indice1 == 4,
repro = wavread('cuatro.wav');
end
if  indice1 == 5,
repro = wavread('cinco.wav');
end

plot(repro);

x=sort(repro);
contar = 0;
for j=2:length(x)
    if x(j)~=x(j-1)
        contar = contar + 1;
    end
end
contar1=fix(log2(contar))+1;
set(handles.text6,'string',strcat('Número de muestras: ',num2str(contar)));
set(handles.text7,'string',strcat('Número mínimo de bits: ',num2str(contar1)));



% --- Executes during object creation, after setting all properties.
function audio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frecuencia_Callback(hObject, eventdata, handles)
% hObject    handle to frecuencia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frecuencia as text
%        str2double(get(hObject,'String')) returns contents of frecuencia as a double


% --- Executes during object creation, after setting all properties.
function frecuencia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frecuencia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function duracion_Callback(hObject, eventdata, handles)
% hObject    handle to duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of duracion as text
%        str2double(get(hObject,'String')) returns contents of duracion as a double


% --- Executes during object creation, after setting all properties.
function duracion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reproducir.
function reproducir_Callback(hObject, eventdata, handles)
% hObject    handle to reproducir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
indice1 = get(handles.popupmenu1, 'value');
if indice1 == 1,
[y, Fs] = wavread('uno.wav');
soundsc(y,Fs);
end
if indice1 == 2,
[y, Fs] = wavread('dos.wav');
soundsc(y,Fs);
end
if indice1 == 3,
[y, Fs] = wavread('tres.wav');
soundsc(y,Fs);
end
if indice1 == 4,
[y, Fs] = wavread('cuatro.wav');
soundsc(y,Fs);
end
if indice1 == 5,
[y, Fs] = wavread('cinco.wav');
soundsc(y,Fs);
end


% --- Executes on button press in reproducir2.
function reproducir2_Callback(hObject, eventdata, handles)
% hObject    handle to reproducir2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fs senal_grabada grabada
if grabada 
if ~isempty(fs)
soundsc(senal_grabada,fs);
else
    warndlg('No se ha grabado ningún audio','Advertencia');
end
else
    warndlg('No se hay un archivo cargado para la reproducción','Advertencia');
end


% --- Executes on button press in graficar2.
function graficar2_Callback(hObject, eventdata, handles)
% hObject    handle to graficar2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global senal_grabada fs duracion grabada
indice2 = get(handles.popupmenu2, 'value');

if grabada
    if indice2 == 1
    plot (senal_grabada);
    end
    if indice2 == 2
    t=0:1/fs:(duracion-(1/fs));
    plot (t,senal_grabada);
    end
    if indice2 == 3
    stairs (senal_grabada);
    end
    x=sort(senal_grabada);
    contar = 0;
    for j=2:length(x)
        if x(j)~=x(j-1)
            contar = contar + 1;
        end
    end
    contar1=fix(log2(contar))+1;
    set(handles.text6,'string',strcat('Número de muestras: ',num2str(contar)));
    set(handles.text7,'string',strcat('Número mínimo de bits: ',num2str(contar1)));
else 
    warndlg('Grabe o cargue un audio.');
end

    
    


% --- Executes on selection change in plotter.
function plotter_Callback(hObject, eventdata, handles)
% hObject    handle to plotter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plotter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plotter


% --- Executes during object creation, after setting all properties.
function plotter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bits_Callback(hObject, eventdata, handles)
% hObject    handle to bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bits as text
%        str2double(get(hObject,'String')) returns contents of bits as a double



% --- Executes during object creation, after setting all properties.
function bits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over audio.
function audio_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to audio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global fs senal_grabada grabada
set(handles.bitsave, 'backgroundcolor', 'white');
n = get(handles.bitsave, 'string');
n = str2double(n);
if grabada
if ~(n == 8 | n == 16 | n == 24)
    warndlg('Tasa de bits debe ser 8, 16 o 24','Advertencia');
    set(handles.bitsave, 'backgroundcolor', 'red');
else 
    nombre = 'audio_grabado.wav';
    set(handles.archivocargado,'string',nombre);
    wavwrite(senal_grabada,fs,n,nombre);
    [senal_grabada,fs]=wavread(nombre);
    warndlg(strcat('Guardado como: ',nombre),'Advertencia');
end
end
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function bitsave_Callback(hObject, eventdata, handles)
% hObject    handle to bitsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bitsave as text
%        str2double(get(hObject,'String')) returns contents of bitsave as a double


% --- Executes during object creation, after setting all properties.
function bitsave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bitsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bitmin.
function bitmin_Callback(hObject, eventdata, handles)
% hObject    handle to bitmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 global senal_grabada contar
% a=min(senal_grabada);
% b=max(senal_grabada);
% y=[a:b];
% z=histc(senal_grabada,y);
% [i j]=size(z);
% bitsmin=0;
% for j=1:j
%     if z(i,j)>0
%         bitsmin=bitsmin+1;
%     end
% end
% 
% clc

% fprintf('Nuestro vector tiene %g valores diferentes',bitsmin)
x=sort(senal_grabada);
contar = 0;
for j=2:length(x)
    if x(j)~=x(j-1)
        contar = contar + 1;
    end
end
contar=fix(log2(contar))+1;
set(handles.tbitmin,'string',contar);
    

function tbitmin_Callback(hObject, eventdata, handles)
% hObject    handle to tbitmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbitmin as text
%        str2double(get(hObject,'String')) returns contents of tbitmin as a double


% --- Executes during object creation, after setting all properties.
function tbitmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbitmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
global senal_grabada grabada fs duracion
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
[file,folder]=uigetfile('*.wav');
filename=fullfile(folder,file);
[senal_grabada,fs] = wavread(filename);
duracion = length(senal_grabada)/fs;
set(handles.archivocargado,'string',file);
grabada = 1;
catch error
end
%%%%%%


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global repro
indice1 = get(handles.popupmenu1, 'value');
if indice1 == 1,
repro = wavread('uno.wav');
end
if indice1 == 2,
repro = wavread('dos.wav');
end
if indice1 == 3,
repro = wavread('tres.wav');
end
if indice1 == 4,
repro = wavread('cuatro.wav');
end
if  indice1 == 5,
repro = wavread('cinco.wav');
end
plot(repro);
x=sort(repro);
contar = 0;
for j=2:length(x)
    if x(j)~=x(j-1)
        contar = contar + 1;
    end
end
contar1=fix(log2(contar))+1;
set(handles.text6,'string',strcat('Número de muestras: ',num2str(contar)));
set(handles.text7,'string',strcat('Número mínimo de bits: ',num2str(contar1)));


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global senal_grabada fs duracion grabada
indice2 = get(handles.popupmenu2, 'value');
if grabada
if indice2 == 1
plot (senal_grabada);
end
if indice2 == 2
t=0:1/fs:(duracion-(1/fs));
plot (t,senal_grabada);
end
if indice2 == 3
stairs (senal_grabada);
end
x=sort(senal_grabada);
contar = 0;
for j=2:length(x)
    if x(j)~=x(j-1)
        contar = contar + 1;
    end
end
contar1=fix(log2(contar))+1;
set(handles.text6,'string',strcat('Número de muestras: ',num2str(contar)));
set(handles.text7,'string',strcat('Número mínimo de bits: ',num2str(contar1)));
else 
    warndlg('Grabe o cargue un audio.');
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
