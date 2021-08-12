program tp2;
//Luciana Maciel - Comisión 107
uses crt;
const 
   claveEmp = '1';
   claveCli = '2';
type
    //Alta Ciudades
   tCodCiudades = array [1..4] of string[3];
   tNomCiudades = array [1..4] of string[40];

   //Alta Empresas
   tCodEC = array [1..4 , 1..2] of string[3];
   tDatosEmp = array [1..4 , 1..4] of string[40];

   //Alta Proyectos
   tCant = array [1..3] of integer;    // El índice va a ser igual al codPro
   tEtapaTipo = array [1..3 , 1..2] of char;
   tCodECP = array [1..4, 1..3] of string[3];

   //Alta Clientes
   tDatosCli = array [1..4 , 1..2] of string[40];

var
   codCiudad: tCodCiudades;   //Ciudades
   nomCiudad: tNomCiudades;
   codEC: tCodEC;             //Empresas
   datosEmp: tDatosEmp;
   cantidad: tCant;           //Proyectos
   codECP: tCodECP; 
   etapatipo: tEtapaTipo;
   datosCli: tDatosCli;       //Clientes
   contEmp : array [1..4] of integer;
   i, cont, posicion, mayor, n : integer;

function validacionClave(x : string) : string;
var
   clave, ocult : string;
begin
   n := 0;
   ocult :='';
   clave := '';
   repeat
      write('Ingrese clave: ');
      ocult := readkey;
      while ocult <> #13 do
      begin
         clave += ocult;
         write('*');
         ocult := readkey;
      end;
      n +=1;
      if (clave <> x) then
      begin
         clave := '';
         writeln();
         textcolor(red);
         writeln('Clave INCORRECTA');
         textcolor(yellow);
      end;
   until (clave = x) or (n = 3);
   validacionClave := clave;
   if (clave = x) and (n <= 3) then
   begin
      writeln();
      textcolor(green);
      writeln('CLAVE CORRECTA');
      textcolor(yellow);
      write('Presione una tecla para continuar.. ');
      readkey;
   end;

end;

//aca con ciudad

function validacionCiudad(x : string): boolean;
var
   bandera: boolean;
begin
   bandera := false;
   for i := 1 to 4 do
   begin
      if codCiudad[i] = x then
      begin
         bandera := true;
      end
   end;
   validacionCiudad := bandera
end;

procedure ordenarAscendente;
var
   i,j: integer;
   aux1 : string[3];
   aux2 : string[40];
begin
   for i := 1 to 3 do
   begin
      for j := i+1 to 4 do
      begin
         if codCiudad[i] > codCiudad[j] then
         begin
            aux1 := codCiudad[i];
            codCiudad[i] := codCiudad[j];
            codCiudad[j] := aux1;
            aux2 := nomCiudad[i];
            nomCiudad[i] := nomCiudad [j];
            nomCiudad[j] := aux2;
         end; 
      end;
   end;
end;

procedure cargaCiudad(x : string);
begin
   while (x <>'*') do 
   begin
      if codCiudad[1] = '' then
      begin
         codCiudad[1] := x;
         write('Ingrese nombre de ciudad: ');
         readln(nomCiudad[1]);
      end;
      x := '*';
   end;
   ordenarAscendente();
end;

procedure altaCiudades;
var
   cod_Ciudad : String[3];
begin
   clrscr;
   repeat
      if cont <= 4 then
      begin
         writeln('Un asterisco en el codigo representa el Fin de datos');
         repeat
            write('Ingrese codigo de ciudad: ');
            readln(cod_Ciudad);
         until (validacionCiudad(cod_Ciudad) = false);
         if cod_Ciudad <> '*' then
         begin
            cont +=1 ;
            cargaCiudad(cod_Ciudad);
         end;
      end
      else
      begin
         cod_Ciudad := '*';
      end;
   until (cod_Ciudad = '*');
   for i := 1 to 4 do
   begin
      if codCiudad[i] <> '' then
      begin
         writeln(codCiudad[i],' - ', nomCiudad[i]);
      end;
   end;
   write('Presione una tecla para continuar.. ');
   readkey();
end;

//aca empieza con empresas

function validacionEmpresa(x : string): Boolean;
var
   bandera: boolean;
   i : integer;
begin
   bandera := false;
   for i := 1 to 3 do
   begin
      if codEC[i,1] = x then
      begin
         bandera := true;
      end;
   end;
   validacionEmpresa := bandera;
end;

function buscarPosVacia : integer;
var
   pos : integer;
begin
   i := 0;
   repeat
      i +=1;
      if codEC[i,1] = '' then
      begin
         pos:=i;
      end;
   until (i <= 4) and (codEC[i,1] ='');
   buscarPosVacia := pos;
end;

function buscarPosDico(x : string) : Boolean;
var
   inicio, fin, medio : Integer;
begin
   inicio := 1;
   fin := 4;
   medio := (inicio + fin)div 2;
   while (codCiudad[medio] <> x) and (inicio <= fin) do
   begin
      if codCiudad[medio] > x then
      begin
         fin := medio -1;
         medio := (inicio + fin)div 2;
      end
      else
      begin
         inicio := medio +1;
         medio := (inicio + fin)div 2;
      end;
   end;
   if codCiudad[medio] = x then
   begin
      buscarPosDico := true;
   end 
   else
   begin
      buscarPosDico := false;
   end;
end;

function buscar(x : string; x_2 : integer): boolean;
var
   bandera: boolean;
begin
   bandera := false;
   for i := 1 to 4 do
   begin
      if codEC[i,x_2] = x then
      begin
         bandera :=true;
      end;
   end;
   buscar :=bandera;
end;

procedure cargaEmpresa(x : string; x_2  : integer);
var
   cod_ciudad : string[3];
   nombreEmpresa, correo, direccion, telefono : String[40];
begin
   codEC[x_2,1] := x;
   repeat
      write('Ingrese el nombre de la empresa: ');
      readln(nombreEmpresa);
   until (buscar(nombreEmpresa,1) = false);
   datosEmp[x_2,1] := nombreEmpresa;
   repeat
      write('Ingrese la direccion de la empresa: ');
      readln(direccion);
   until (buscar(direccion,2) = false);
   datosEmp[x_2,2] := direccion;
   repeat
      write('Ingrese el correo de la empresa: ');
      readln(correo);
   until (buscar(correo,3) = false);
   datosEmp[x_2,3] := correo;
   repeat
      write('Ingrese el telefono de la empresa: ');
      readln(telefono);
   until (buscar(telefono,4) = false);
   datosEmp[x_2,4] := telefono;
   write('Ingrese codigo de ciudad: ');
   readln(cod_ciudad);
   if (buscarPosDico(cod_ciudad)) then
   begin
      codEC[x_2,2] := cod_ciudad;
      for i := 1 to 4 do
      begin
         if codCiudad[i] = cod_ciudad then
         contEmp[i] += 1;
      end;
   end
   else if (x_2 <= 4) and (buscarPosDico(cod_ciudad) = false) then
   begin
      cargaCiudad(cod_ciudad);
      codEC[x_2,2] := cod_ciudad;
      for i := 1 to 4 do
      begin
         if codCiudad[i] = cod_ciudad then
            contEmp[i] += 1;
      end;
   end
   else
   begin
      writeln('No se puede ingresar codigo de ciudad. Limite completo.');
   end;
   begin
   textcolor(green);
   writeln('La empresa fue cargada correctamente');
   textcolor(yellow);
   end;
   for i := 1 to 4 do
   begin
      if contEmp[i] > mayor then
      begin
         mayor := contEmp[i];
         posicion := i;
      end;
   end;
   if mayor > 0 then
   begin
      writeln();
      writeln ('Ciudad con mayor cantidad de empresas:');
      writeln ('Codigo: ', codCiudad[posicion] , '  Nombre: ', nomCiudad[posicion], '  Cantidad de empresas: ', mayor);
      readkey();
   end;
end;

procedure altaEmpresas;
var
   cod_empresa : string[3];
   pos: integer;
begin
   clrscr;
   pos := 0;
   mayor := 0;
   posicion := 0;
   for i := 1 to 4 do
      contEmp[i] := 0;
   repeat
      if pos <= 4 then
      begin
         repeat
            write('Ingrese el codigo de empresa: ');
            readln(cod_empresa);
            if validacionEmpresa(cod_empresa) then
               writeln('La empresa ya fue cargada previamente');
         until (validacionEmpresa(cod_empresa) = false);
         if (cod_empresa <> '*')  then
         begin
            pos := buscarPosVacia;
            cargaEmpresa(cod_empresa,pos);
            writeln('');
         end;
      end
      else
      begin
         cod_empresa := '*';
      end;
   until (cod_empresa = '*');
   for i := 1 to 4 do
   begin
      if codCiudad[i] <> '' then
      begin
         writeln();
         writeln('Codigo - Nombre - Cantidad de empresas');
         writeln(codCiudad[i] ,' - ' , nomCiudad[i], ' - ' , contEmp[i]);
      end;
      readkey;
   end;
end;

//aca con proyectos

function buscarCE(x : string; x_2 : integer): boolean;
var
   bandera: boolean;
begin
   bandera := false;
   for i := 1 to 4 do
   begin
      if codECP[i,x_2] = x then
      begin
         bandera := true;
      end;
   end;
   buscarCE := bandera;
end;

function buscarPosVaciaCodPro : integer;
var
   pos : integer;
begin
   i := 0;
   repeat
      i +=1;
      if codECP[i,1] = '' then
      begin
         pos:=i;
      end;
   until (i <= 4) and (codECP[i,1] ='');
   buscarPosVaciaCodPro := pos;
end;

procedure altaProductos;
begin
     clrscr;
     writeln ('Programa en proceso..');
     write('Presione una tecla para continuar.. ');
     readkey;
end;


procedure altaProyectos;
var
   codPROYECTO, codEMPRESA, codCIUDAD: string[3];
   pos : integer;
   etapa, tipo : char;
begin
   repeat
      clrscr;
      repeat
         write('Ingrese el codigo de proyecto: ');
         readln(codPROYECTO);
      until buscarCE(codPROYECTO,1) = false;
      if codPROYECTO <> '*' then
      begin
         pos := buscarPosVaciaCodPro;
         codECP[pos,1] := codPROYECTO;
         cont := buscarPosVacia;
         write('Ingrese el codigo de empresa: ');
         readln(codEMPRESA);
         if (buscar(codEMPRESA,1)) and (codEMPRESA <> '*') then
         begin
            codECP[pos,2] := codEMPRESA;
            writeln('Ingrese el codigo de ciudad: ');
            readln(codCIUDAD);
            if buscarPosDico(codCIUDAD) then
            begin
               codECP[pos,3] := codCIUDAD;
            end
            else if (codCiudad <> '*') and ( codCiudad[1] = '') then
            begin
               cargaCiudad(codCIUDAD);
               codECP[pos,3] := codCIUDAD;
            end
            else
            begin
               repeat
                  writeln('Ingrese un codigo de ciudad ya cargado. No se permite la carga de nuevos codigos');
                  for i := 1 to 1 do
                  begin
                     writeln(codCiudad[i]);
                  end;
                  readln(codCIUDAD);
               until buscarPosDico(codCIUDAD) = true;
               codECP[pos,3] := codCIUDAD;
            end;
            repeat
               writeln('Ingrese una de las siguientes etapas: PREVENTA (P), OBRA (O), TERMINADO (T) ');
               readln(etapa);
            until (etapa = 'P') or (etapa = 'O') or (etapa = 'T') or (etapa = 'p') or (etapa = 'o') or (etapa = 't');
            etapatipo[pos,1] := etapa;
            repeat
               writeln('Ingrese uno de los siguientes tipo: CASA(C), DEPARTAMENTO (D), OFICINA (O), LOTES (L) ');
               readln(tipo);
            until (tipo = 'C') or (tipo = 'O') or (tipo = 'L') or (tipo = 'D') or (tipo = 'c') or (tipo = 'o')or (tipo = 'l') or (tipo = 'd');
            etapatipo[pos,2] := tipo;
         end
         else if (codEMPRESA <> '*') and (cont <= 4) and (cont > 0) and (buscar(codEMPRESA,1) = false) then 
         begin
            writeln('El codigo de Empresa no existe, por favor ingrese dicha empresa a continuacion');
            cargaEmpresa(codEMPRESA, cont);
            codEC[pos,2] := codEMPRESA;
            repeat
            writeln('Ingrese una de los siguientes etapas: PREVENTA (P), OBRA (O), TERMINADO (T) ');
               readln(etapa);
            until (etapa = 'P') or (etapa = 'O') or (etapa = 'T') or (etapa = 'p') or (etapa = 'o') or (etapa = 't');
            etapatipo[pos,1] := etapa;
            repeat
               writeln('Ingrese uno de los siguientes tipo: CASA(C), DEPARTAMENTO (D), OFICINA (O), LOTES (L) ');
               readln(tipo);
            until (tipo = 'C') or (tipo = 'O') or (tipo = 'D') or (tipo = 'L') or (tipo = 'o') or (tipo = 'd')or (tipo = 'c') or (tipo = 'l');
            etapatipo[pos,2] := tipo;
         end
         else if (cont = 0) or (cont > 4) then
         begin
            write('No es posible cargar dicha empresa');
            writeln('Por favor ingrese uno de los siguientes codigo de empresa: ');
            for i := 1 to 4 do
            begin
               writeln(codEC[i,1]);
            end;
            repeat
               readln(codEMPRESA);
            until validacionEmpresa(codEMPRESA);
            codECP[pos,2]:=codEMPRESA;
         end;
      end;
   until codPROYECTO = '*';  
end;

procedure empresas();
var
   op: Integer;
   clave : string;
begin
   clave:= validacionClave(claveEmp);
   clrscr;
   if (clave = claveEmp) and (n <= 3) then
   begin
      repeat
         repeat
            clrscr;
            writeln('Menu Empresas Desarrolladoras');
            writeln('1- Alta CIUDADES');
            writeln('2- Alta EMPRESAS');
            writeln('3- Alta PROYECTOS');
            writeln('4- Alta PRODUCTOS');
            writeln('0- Volver al Menu Principal');
            write('Ingrese opcion: ');
            readln(op);
         until (op >= 0) and (op <= 4);
         case op of
            1: altaCiudades;
            2: altaEmpresas;
            3: altaProyectos;
            4: altaProductos;
         end
      until op = 0;
   end
   else
   begin
      textcolor(red);
      writeln('Clave INCORRECTA. Supera los tres intentos');
      textcolor(yellow);
      write('Presione una tecla para volver al Menu Principal.. ');
      readkey;
   end;
   clrscr;
end;

function validacion(x : string; x_2 : integer): Boolean;
var
   bandera: boolean;
begin
   bandera := false;
   for i := 1 to 4 do
   begin
      if datosCli[i,x_2] = x then
      begin 
         bandera := true;
      end;
   end;
   validacion := bandera;
end;

function posvacia : integer;
var
   posicion : Integer;
begin
   posicion := 0;
   for i := 1 to 4 do
   begin
      if (datosCli[i,1] = '') then
      begin
         posicion := i;
      end;
   end;
   posvacia := posicion;
end;

procedure altaClientes;
var
   mail,nombre: string;
begin
   clrscr;
   posicion := posvacia;
   repeat
      if (posicion <= 4) and (posicion > 0) then
      begin
         repeat
            writeln('Ingrese el nombre y apellido del cliente: ');
            readln(nombre);
            if validacion(nombre,1) then
            begin
               write('Ingrese otro nombre: ');
            end;
         until (validacion(nombre,1) = false) and (posicion <= 4);
         if (nombre <>'*') and (posicion <= 4) and(posicion >0) then
         begin
            datosCli[posicion,1] := nombre;
            repeat
               write('Ingrese el correo del cliente:');
               readln(mail);
               if validacion(mail,2) then
               begin
                  write('Ingrese otro correo: ');
               end;
            until (validacion(mail,2) = false) and (mail <> '*');
            if (posicion <= 4) then
            begin
               datosCli[posicion,2] := mail;
            end;
         end;
      posicion := posvacia;
      end
      else
      begin
         nombre := '*';
      end;
   until (nombre = '*');
   writeln(posicion);
   for i := 1 to 4 do
   begin
      if datosCli[i,1] <> '' then
      begin
         writeln(datosCli[i,1], ' ', datosCli[i,2]);
      end;
   end;
   readkey;
end;

function buscarTipoDeProyecto(t : char): boolean;
var
   j: integer;
   codEmp, codCiu: string[3];
   bandera, found:boolean;
begin
   bandera := false;
   codEmp := '';
   codCiu := '';
   for i := 1 to 3 do
   begin
      if etapatipo[i,2] = t then
      begin
         bandera := true;
         
         //Nombre de la Etapa
         case etapatipo[i,1] of
         'p': writeln('Nombre de la Etapa: PREVENTA');
         'o': writeln('Nombre de la Etapa: OBRA');
         't': writeln('Nombre de la Etapa: TERMINADO');
         'P': writeln('Nombre de la Etapa: PREVENTA');
         'O': writeln('Nombre de la Etapa: OBRA');
         'T': writeln('Nombre de la Etapa: TERMINADO');
         end;
         
         //Nombre de la Empresa
         codEmp := codECP[i,2];
         codCiu := codECP[i,3];

         writeln('Codigo empresa: ', codECP[i,2]);
         writeln('Codigo ciudad: ', codECP[i,3]);

         j := 0;
         found := false;
         while found = false do
         begin
            j += 1;
            if codEC[j,1] = codEmp then
            begin
               found := true;
               writeln('Nombre de la Empresa:', datosEmp[j,1]);
            end;
         end;
   
         //Nombre de la Ciudad
         found := false;
         j := 0;
         while found = false do
         begin
            j += 1;
            writeln('Codigo en el array: ', codCiudad[j],' - Codigo a buscar: ', codCiu );
            if codCiudad[i] = codCiu then
            begin
               found := true;
               writeln('Nombre de la Ciudad: ', nomCiudad[j]);
            end;
         end;

         //Retorno
         buscarTipoDeProyecto := bandera;   
      end;
   end;
   buscarTipoDeProyecto := bandera;
end;

procedure consultaProyectos;
var
   tipoProy: char;
   bandera: boolean;
begin
   clrscr;
   repeat
      begin
         writeln ('Casa(C), departamento (D), oficina (O), loteos (L)');
         write('Ingrese Tipo de Proyecto: ');
         readln(tipoProy);
      end
   until (tipoProy = 'c') or (tipoProy = 'o') or (tipoProy = 'l') or (tipoProy = 'd') or (tipoProy = 'C') or (tipoProy = 'O') or (tipoProy = 'L') or (tipoProy = 'D');
   
   //Valido si existe Proyecto por Tipo, si no existe retorno False
   bandera := buscarTipoDeProyecto(tipoProy);

   if (bandera = false) then
   begin
      writeln('No hay proyecto para el Tipo Indicado');
   end;


   readkey;
end;

procedure clientes;
var
   op: Integer;
   clave : string;
begin
   clave:= validacionClave(claveCli);
   clrscr;
   if clave = claveCli then
   begin
      repeat
         repeat
            clrscr;
            writeln('Menu de Clientes');
            writeln('1- Alta CLIENTE');
            writeln('2- Consulta de proyecto');
            writeln('0- Volver al Menu Principal');
            write('Ingrese opcion: ');
            readln(op);
         until (op >= 0) and (op <= 2);
         case op of
            1 : altaClientes;
            2 : consultaProyectos;
         end
      until op = 0;
   end
   else
   begin
      textcolor(red);
      writeln('Clave INCORRECTA. Supera los tres intentos');
      textcolor(yellow);
      write('Presione una tecla para volver al Menu Principal.. ');
      readkey;
   end;
   clrscr;
end;

procedure menuprincipal();
var
   op : integer;
begin
   clrscr;
   repeat
      repeat
         //clrscr;
         writeln('Menu Principal');
         writeln('1- EMPRESAS');
         writeln('2- CLIENTES');
         writeln('0- Salir');
         write('Ingrese opcion: ');
         readln(op);
      until (op >= 0) and (op <= 2);
      clrscr;
      case op of
         1: empresas;
         2: clientes;
      end
   until op = 0;
end;

begin
   cont := 0;
   for i := 1 to 4 do
   begin
      codCiudad[i] := '';
      contEmp[i] := 0;
   end;
   textcolor(yellow);
   textbackground(blue);
   menuprincipal();
   readkey();
end.
