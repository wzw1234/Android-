function varargout = biyesheji(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @biyesheji_OpeningFcn, ...
                   'gui_OutputFcn',  @biyesheji_OutputFcn, ...
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

function biyesheji_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
%���ñ���
ha=axes('units','normalized','pos',[0 0 1 1]);
uistack(ha,'bottom');    %���ڵײ���buttom
ii=imread('beijing.jpg');   %�ڵ�ǰ�ļ����µ�ͼƬ����
image(ii);
colormap gray
set(ha,'handlevisibility','off','visible','off');


guidata(hObject, handles);





function varargout = biyesheji_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function pushbutton1_Callback(hObject, eventdata, handles)

% ɾ����������
delete(instrfindall);
persistent c
if isempty(c)
phoneIP =get(handles.edit3,'String');
port = str2double(get(handles.edit2,'String'));
%phoneIP = '192.168.0.106';
%port = 5555;
u = udp(phoneIP , port - 1 , 'LocalPort' , port , 'InputBufferSize' , 1024);
fopen(u);
% Ԥ����
msgMat = zeros(99,3);
k = 1;
global stop;
stop = 1;
while k < 1000
    [msg,~] = fread(u,10);
    msgCell = strsplit(char(msg)',',');
    % ��֤������������.
   if size(msgCell,2) == 6
        msgNum = [str2double(msgCell{4}) str2double(msgCell{5}) str2double(msgCell{6})];
    else
        msgNum = zeros(1,3);
    end
%����˳�
if stop==0
    break;
end
drawnow()
    if k < 100
        msgMat(k,:) = msgNum;
    else
        msgMat = [msgMat(2:end,:) ; msgNum];
    end
    % ת�����ַ������
   % fprintf('%s\n',char(msg)');
if msgCell{1}=="gx"
    if msgNum(1)>5
    set(handles.text10,'String',"����");
    elseif msgNum(1)<1
    set(handles.text10,'String',"����");
    else
    set(handles.text10,'String',"");
    end
axes(handles.a1)
 plot(msgMat);
 legend('x','y','z');
elseif msgCell{1}=="ax"
    if msgNum(1)>10
    set(handles.text11,'String',"��");
    elseif msgNum(1)<10&&msgNum(1)>3
    set(handles.text11,'String',"��");
    else
    set(handles.text11,'String',"����");
    end
    axes(handles.a2)
 plot(msgMat);
 legend('x','y','z');
elseif msgCell{1}=="tx"
    if msgNum(2)>0.4
    set(handles.text9,'String',"��ҡ");
    elseif msgNum(2)<-0.4
    set(handles.text9,'String',"��ҡ");
    else
    set(handles.text9,'String',"");
    end
     axes(handles.a3)
 plot(msgMat);
 legend('x','y','z');
 elseif msgCell{1}=="ox"
     if abs(msgNum(2))>100
    set(handles.text8,'String',"�ֻ�����");
    else
    set(handles.text8,'String',"�ֻ�û�е���");
    end
     axes(handles.a4)
 plot(msgMat);
 legend('x','y','z');
end
%drawnow
    k = k + 1;


end
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
persistent c
global stop;
if isempty(c)
   stop=0;
end


% --- Executes on mouse press over axes background.
function a1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function a1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ɾ����������
delete(instrfindall);
persistent c
global stop;
stop = 1;
if isempty(c)
phoneIP =get(handles.edit3,'String');
%port = str2double(get(handles.edit2,'String'));
%phoneIP = '192.168.0.106';
port=1234;
port2=1235;
port3=1236;
port4=1237;
u = udp(phoneIP , port - 1 , 'LocalPort' , port , 'InputBufferSize' , 1024);
u2 = udp(phoneIP , port2 - 1 , 'LocalPort' , port2 , 'InputBufferSize' , 1024);
u3 = udp(phoneIP , port3 - 1 , 'LocalPort' , port3 , 'InputBufferSize' , 1024);
u4 = udp(phoneIP , port4 - 1 , 'LocalPort' , port4 , 'InputBufferSize' , 1024);
fopen(u);
fopen(u2);
fopen(u3);
fopen(u4);
% Ԥ����
msgMat = zeros(99,3);
msgMat2 = zeros(99,3);
msgMat3 = zeros(99,3);
msgMat4 = zeros(99,3);
k = 1;
while k < 1000
    [msg,~] = fread(u,10);
    msgCell = strsplit(char(msg)',',');
    %����˳�
if stop==0
    break;
end
drawnow()
    % ��֤������������.
   if size(msgCell,2) == 6
        msgNum = [str2double(msgCell{4}) str2double(msgCell{5}) str2double(msgCell{6})];
   else
       if k<100
        msgNum = msgMat(k-1,:);
        %msgNum = zeros(1,3);
       else
        if rem(k,99)~=0
        msgNum = msgMat(rem(k,99),:);
           else
         msgNum = msgMat(rem(k,99)+1,:);      
        end
       end
    end
%�����������ж��ֻ�������

    if k < 100
        msgMat(k,:) = msgNum;
    else
        msgMat = [msgMat(2:end,:) ; msgNum];
    end
    % ת�����ַ������
   % fprintf('%s\n',char(msg)');
   [msg2,~] = fread(u2,10);
    msgCell2 = strsplit(char(msg2)',',');
    % ��֤������������.
   if size(msgCell2,2) == 6
        msgNum2 = [str2double(msgCell2{4}) str2double(msgCell2{5}) str2double(msgCell2{6})];
   else
       if k<100
        msgNum2 = msgMat2(k-1,:);
        %msgNum2 = zeros(1,3);
       else
           if rem(k,99)~=0
        msgNum2 = msgMat2(rem(k,99),:);
           else
         msgNum2 = msgMat2(rem(k,99)+1,:);      
           end
       end
    end


    if k < 100
        msgMat2(k,:) = msgNum2;
    else
        msgMat2 = [msgMat2(2:end,:) ; msgNum2];
    end
    % ת�����ַ������
   % fprintf('%s\n',char(msg)');

 [msg3,~] = fread(u3,10);
    msgCell3 = strsplit(char(msg3)',',');
    % ��֤������������.
   if size(msgCell3,2) == 6
        msgNum3 = [str2double(msgCell3{4}) str2double(msgCell3{5}) str2double(msgCell3{6})];
   else
       if k<100
        msgNum3 = msgMat3(k-1,:);
        %msgNum3 = zeros(1,3);
       else
        if rem(k,99)~=0
        msgNum3 = msgMat3(rem(k,99),:);
           else
         msgNum3 = msgMat3(rem(k,99)+1,:);      
        end  
       end
    end


    if k < 100
        msgMat3(k,:) = msgNum3;
    else
        msgMat3 = [msgMat3(2:end,:) ; msgNum3];
    end
    % ת�����ַ������
   % fprintf('%s\n',char(msg)');
  
[msg4,~] = fread(u4,10);
    msgCell4 = strsplit(char(msg4)',',');
    % ��֤������������.
   if size(msgCell4,2) == 6
        msgNum4 = [str2double(msgCell4{4}) str2double(msgCell4{5}) str2double(msgCell4{6})];
   else
        if k<100
        msgNum4 = msgMat4(k-1,:);
        %msgNum4 = zeros(1,3);
       else
        if rem(k,99)~=0
        msgNum4 = msgMat4(rem(k,99),:);
           else
         msgNum4 = msgMat4(rem(k,99)+1,:);      
        end
       end
   end

    if k < 100
        msgMat4(k,:) = msgNum4;
    else
        msgMat4 = [msgMat4(2:end,:) ; msgNum4];
    end
    % ת�����ַ������
   % fprintf('%s\n',char(msgMat4)');
 
if abs(msgNum2(2))>100
    set(handles.text8,'String',"�ֻ�����");
else
    set(handles.text8,'String',"�ֻ�û�е���");
end
if msgNum(1)>5
    set(handles.text10,'String',"����");
elseif msgNum(1)<1
    set(handles.text10,'String',"����");
else
    set(handles.text10,'String',"");
end
if msgNum4(2)>0.4
    set(handles.text9,'String',"��ҡ");
elseif msgNum4(2)<-0.4
    set(handles.text9,'String',"��ҡ");
else
    set(handles.text9,'String',"");
end
if msgNum3(1)>10
    set(handles.text11,'String',"��");
elseif msgNum3(1)<10&&msgNum3(1)>3
    set(handles.text11,'String',"��");
else
    set(handles.text11,'String',"����");
end

if msgCell{1}=="gx"
axes(handles.a1)
 plot(msgMat);
 legend('x','y','z');
end
if msgCell2{1}=="ox"
    axes(handles.a4)
 plot(msgMat2);
 legend('x','y','z');
end
if msgCell3{1}=="ax"
     axes(handles.a2)
 plot(msgMat3);
 legend('x','y','z');
end
if msgCell4{1}=="tx"
     axes(handles.a3)
 plot(msgMat4);
 legend('x','y','z');
end

%drawnow
    k = k + 1;
end



end

