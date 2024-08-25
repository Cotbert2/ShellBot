% Leer datos en un bucle
disp('Esperando datos...');
while true
    % Leer datos desde el dispositivo Bluetooth
    data = readline(bt);
    
    % Mostrar los datos recibidos
    fprintf('Distancia recibida: %s\n', data);
end

% Cuando termines, limpia el objeto para cerrar la conexión
clear bt;