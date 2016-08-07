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

% Last Modified by GUIDE v2.5 23-Oct-2015 20:05:01

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

function graficar(handles,x,color)
axes(handles.axes1);
stem(x,color);
axis([0 100 0 100]);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)%derecha
t0 = 5;
t1 = 0.1;
global oprimido;
global velocidad;
global conexion;
global direccion;
if oprimido==0
oprimido=1;
direccion=1;
x=zeros(1,101);
graficar(handles,x,'blue');
writePWMDutyCycle(conexion,9,0);
writePWMDutyCycle(conexion,10,0);
pause(t0);
for i=0:velocidad
    writePWMDutyCycle(conexion,9,i/100);
    x(i+1)=i;
    graficar(handles,x,'blue');
    pause(t1);
end;
oprimido=0;
end;
    
    
function pushbutton2_Callback(hObject, eventdata, handles)%izquierda
t0 = 5;
t1 = 0.1;
global oprimido;
global direccion;
global conexion;
global velocidad;
if oprimido==0
oprimido=1;
direccion=2;
x=zeros(1,101);
graficar(handles,x,'red');
writePWMDutyCycle(conexion,9,0);
writePWMDutyCycle(conexion,10,0);
pause(t0);
for i=0:velocidad
    writePWMDutyCycle(conexion,10,i/100);
    x(i+1)=i;
    graficar(handles,x,'red');
    pause(t1);
end;
oprimido=0;
end;

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
t1 = 0.1;
global velocidad;
velocidad=get(handles.slider1,'Value')*100;
global oprimido;
global conexion;
global direccion;
global velanterior;
if oprimido==0 && (direccion==1 || direccion==2)
    oprimido=1;
    x=zeros(1,101);
    vel=[velanterior,velocidad];
    mat=min(vel):max(vel);
    if(velanterior>velocidad)
        mat=sort(mat,'descend');
    end;
    velanterior=velocidad;
    for i=mat
        if direccion==1%derecha
            writePWMDutyCycle(conexion,9,fix(i)/100);
            x(fix(i)+1)=i;
            graficar(handles,x,'blue');
        elseif direccion==2%izquierda
            writePWMDutyCycle(conexion,10,fix(i)/100);
            x(fix(i)+1)=i;
            graficar(handles,x,'red');
        end;
        pause(t1);
    end;
    oprimido=0;
end;

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
clear all;
global conexion;
conexion=arduino('COM4', 'uno');
writePWMDutyCycle(conexion,9,0);
writePWMDutyCycle(conexion,10,0);
global oprimido;
oprimido = 0;
global velocidad;
velocidad = 100;
global direccion;
direccion = 0;%1 derecha; 2 izquierda
global velanterior;
velanterior = 100;
