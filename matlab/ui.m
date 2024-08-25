
function varargout = ui(varargin)
% UI MATLAB code for ui.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ui

% Last Modified by GUIDE v2.5 21-Aug-2024 22:55:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui_OpeningFcn, ...
                   'gui_OutputFcn',  @ui_OutputFcn, ...
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
end

% --- Executes just before ui is made visible.
function ui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ui (see VARARGIN)

% Choose default command line output for ui

handles.imageLeft = imread('./assets/left.png')
handles.imageUp = imread('./assets/up.png')
handles.imageDown = imread('./assets/down.png')
handles.imageRight = imread('./assets/der.png')
handles.bt=bluetooth('00:20:10:08:CE:F5',1);
fopen(handles.bt)


handles.logoShell = imresize(imread('./assets/logopo.png'),0.4)
handles.logoImg = imresize(imread('./assets/ESPE.png'),0.1)

handles.stateButton = false;
handles.fulltime = 0;

set(handles.pushbutton4, 'CData', handles.imageUp);
set(handles.pushbutton1, 'CData', handles.imageLeft);
set(handles.pushbutton2, 'CData', handles.imageDown);
set(handles.pushbutton3, 'CData', handles.imageRight);


set(handles.pushbutton5, 'CData', handles.logoImg);
set(handles.pushbutton7, 'CData', handles.logoShell);

handles.distanceValue = 3;
set(handles.edit2, 'String', num2str(handles.distanceValue))

set(handles.figure1, 'CloseRequestFcn', @(src, event) ui_CloseRequestFcn(src, event, handles));



%buttons config

set(handles.pushbutton1, 'ButtonDownFcn', @(hObject, eventdata) pushbutton1_ButtonDownFcn(hObject, eventdata, handles));
set(handles.pushbutton2, 'ButtonDownFcn', @(hObject, eventdata) pushbutton2_ButtonDownFcn(hObject, eventdata, handles));
set(handles.pushbutton3, 'ButtonDownFcn', @(hObject, eventdata) pushbutton3_ButtonDownFcn(hObject, eventdata, handles));
set(handles.pushbutton4, 'ButtonDownFcn', @(hObject, eventdata) pushbutton4_ButtonDownFcn(hObject, eventdata, handles));
handles.dataMatrix = 0;
guidata(hObject, handles);

set(handles.figure1, 'WindowButtonUpFcn', @(hObject, eventdata)pushbutton1_ButtonUpFcn(hObject, eventdata, handles));

set(gcf, 'Renderer', 'opengl'); 


%Subritnes



handles.t = timer;
handles.t.Period = 1; % Intervalo de 1 segundo
handles.t.ExecutionMode = 'fixedRate'; % Ejecutar a intervalos regulares
handles.t.TimerFcn = @(~,~) updateData(hObject,  eventdata, handles); % Función callback

% Start Timer
start(handles.t);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = ui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;

end
% --- Executes on button press in pushbutton1.


function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('left ButtonDown detected');
fopen(handles.bt)
fwrite(handles.bt,'i');
end

function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('backward ButtonDown detected');
fopen(handles.bt)

fwrite(handles.bt,'r');
end

function pushbutton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('right ButtonDown detected');
fopen(handles.bt)

fwrite(handles.bt,'d');

end

function pushbutton4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp(handles);
disp('should forward')
fopen(handles.bt)
                
fwrite(handles.bt,'a');
end


function pushbutton1_ButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fwrite(handles.bt,'o');
disp('Up detection');
end





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('down')
handles.distanceValue = 20;
set(handles.edit2, 'String', num2str(handles.distanceValue))
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('right')
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('up')
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


function edit2_Callback(hObject, eventdata, handles)


% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

end
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton3.

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on pushbutton4 and none of its controls.

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.




% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on pushbutton3 and none of its controls.
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
end

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
    disp('Starting detection');
    
    % get available devices
    handles.btDevices = bluetoothlist;
    
    % scrapp devices name
    if ~isempty(handles.btDevices)
        items = {handles.btDevices.Name};
    else
        items = {'No se encontraron dispositivos'};
    end
    
    disp(items);
    
    % show devices in list
    set(handles.listbox2, 'String', items);
end
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
    handles.bt=bluetooth('00:20:10:08:CE:F5',1);
    guidata(hObject, handles);
    disp(handles.bt)
    fopen(handles.bt);
    disp(handles)
end
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function updateData(hObject, eventdata, handles)
    if handles.bt.NumBytesAvailable > 0
        % Read all data available
        data = splitlines(read(handles.bt, handles.bt.NumBytesAvailable, "char")); 
        numericData = str2double(data(~cellfun('isempty', data)));

        % concat info matrix
            
        if ~isfield(handles, 'dataMatrix')
            handles.dataMatrix = numericData;
        else
            handles.dataMatrix = [handles.dataMatrix; numericData];
        end
        
        set(handles.edit2, 'String', num2str(numericData(end)));
        guidata(hObject, handles);
        
    end
end

function ui_CloseRequestFcn(hObject, eventdata, handles)
    delete(hObject)
    delete(handles.bt)
    delete(handles.t)
    disp('close')

end


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
disp(handles.dataMatrix)
    if(~handles.stateButton)
        set(handles.pushbutton11, 'String', 'Stop Interpolation')
        tic;
    else
        set(handles.pushbutton11, 'String', 'Start Interpolation')
        handles.fulltime = toc;
        fprintf('El tiempo transcurrido es %.2f segundos.\n', handles.fulltime);
        disp('size de dataMatrix');
        handles.dataMatrix = handles.dataMatrix';
        [~, numCol] = size(handles.dataMatrix);
        disp(numCol)
        handles.timeVector = linspace(0,handles.fulltime, numCol);
        disp(handles.timeVector);
        % Establecer el axes2 como el destino actual de la gráfica

        x = handles.dataMatrix;
        y = handles.timeVector;

        n = length(x);

        %Realizamos las respectivas sumatorias 
        %de las varibales como x, x^2, x^3, x^4, x^5,x^6
        
        sumatoriax = sum(x);
        sumatoriay = sum(y);
        fprintf("La sumatoria de x es: %.3f",sumatoriax)
        fprintf("\nLa sumatoria de y es: %.3f",sumatoriay)
        
        x_2 = zeros(1,n);
        x_3 = zeros(1,n);
        x_4 = zeros(1,n);
        x_5 = zeros(1,n);
        x_6 = zeros(1,n);
        xy = zeros(1,n);
        x_2y = zeros(1,n);
        x_3y = zeros(1,n);
        for i = 1:n
            x_2(i) = (x(i) * x(i));
            x_3(i) = (x(i) * x(i) * x(i));
            x_4(i) = (x(i) * x(i) * x(i) * x(i));
            x_5(i) = (x(i) * x(i) * x(i) * x(i) * x(i));
            x_6(i) = (x(i) * x(i) * x(i) * x(i) * x(i) * x(i)); 
            xy(i) = (x(i) * y(i));
        end
        
        sumatoriax_2 = sum(x_2);
        fprintf("\nLa sumatoria de los x al cuadrado es: %.3f", sumatoriax_2)
        
        sumatoriax_3 = sum(x_3);
        fprintf("\nLa sumatoria de los x al cubo es: %.3f", sumatoriax_3)
        
        sumatoriax_4 = sum(x_4);
        fprintf("\nLa sumatoria de los x a la cuarta es: %.3f", sumatoriax_4)
        
        sumatoriax_5 = sum(x_5);
        fprintf("\nLa sumatoria de los x a la quinta es: %.3f", sumatoriax_5)
        
        sumatoriax_6 = sum(x_6);
        fprintf("\nLa sumatoria de los x a la sexta es: %.3f",sumatoriax_6)
        
        sumatoriax_y = sum(xy);
        fprintf("\nLa sumatoria de los x* y es: %.3f", sumatoriax_y)
        
        for i = 1:n
            x_2y(i) = (((x(i))^2) * y(i));
            x_3y(i) = (((x(i))^3) * y(i));
        end
        
        sumatoriax_2y = sum(x_2y);
        fprintf("\nLa sumatoria de los x^2* y es: %.3f", sumatoriax_2y)
        
        sumatoriax_3y = sum(x_3y);
        fprintf("\nLa sumatoria de los x^3* y es: %.3f", sumatoriax_3y)
        
        %Generamos la ecuación de tercer orden a la que vamos a hallar sus
        %coeficientes
        syms a0 a1 a2 a3 t t1 t2 t3 y_1 y_x y_x2 t4 y_x3 t5
        expr = y_1 == a0 + a1*t + a2*(t1) + a3*(t2);
        
        %Usamos derivadas parciales para ir hallando las demas ecuaciones
        %y asi poder usar la matriz
        expr1 = y_x == a0*t + a1*(t1)+a2*(t2) + a3*(t3);
        expr2 = y_x2 == a0*(t1) + a1*(t2)+a2*(t3) + a3*(t4);%tercera ecuacion
        expr3 = y_x3 == a0*(t2) + a1*(t3)+ a2*(t4) + a3*(t5);
        
        % Sustituimos x y y en la expresión simbolica
        expr_eval = vpa(subs(expr,[t,t1,t2,y_1],[sumatoriax,sumatoriax_2,sumatoriax_3,sumatoriay]));
        expr_eval1 = vpa(subs(expr1,[t,t1,t2,t3,y_x],[sumatoriax,sumatoriax_2,sumatoriax_3,sumatoriax_4,sumatoriax_y]));
        expr_eval2 = vpa(subs(expr2,[t1,t2,t3,t4,y_x2],[sumatoriax_2,sumatoriax_3,sumatoriax_4,sumatoriax_5,sumatoriax_2y]));
        expr_eval3 = vpa(subs(expr3,[t2,t3,t4,t5,y_x3],[sumatoriax_3,sumatoriax_4,sumatoriax_5,sumatoriax_6,sumatoriax_3y]));
        
        %Creamos la matriz
        matriz = n * [1 sumatoriax sumatoriax_2 sumatoriax_3;sumatoriax sumatoriax_2 sumatoriax_3 sumatoriax_4;
            sumatoriax_2 sumatoriax_3 sumatoriax_4 sumatoriax_5; sumatoriax_3 sumatoriax_4 sumatoriax_5 sumatoriax_6];
        b = n * [sumatoriay ;sumatoriax_y ;sumatoriax_2y; sumatoriax_3y];
        
        %Imprimimos la matriz
        format short
        disp(matriz)
        disp(b)
        
        %imprimimos los coeficientes de la ecuacion de tercer orden
        coeficientes = inv(matriz) * b;
        disp("La matriz de coeficientes es:")
        disp(coeficientes)

        % Generamos puntos para la curva ajustada
        x_fit = linspace(min(x), max(x), 100);
        y_fit = coeficientes(1) + coeficientes(2)*x_fit + coeficientes(3)*x_fit.^2 + coeficientes(4)*x_fit.^3;
    
        % Graficamos los datos originales y la curva ajustada
                axes(handles.axes2);

        plot(x, y, 'bo', 'MarkerFaceColor', 'b'); % Puntos originales
        hold on;
        plot(x_fit, y_fit, 'r-', 'LineWidth', 2); % Curva ajustada
        xlabel('time');
        ylabel('distance');
        title('Ajuste de curva de tercer orden');
        legend('Datos originales', 'Curva ajustada');
        grid on;
        hold off;
    end

        handles.stateButton = ~handles.stateButton;
        guidata(hObject, handles);



    
end
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)