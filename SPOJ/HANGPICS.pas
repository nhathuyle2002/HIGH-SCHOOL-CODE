const   fi='HANGPICS.INP';
        fo='HANGPICS.OUT';
var     a,b,a2,a1,b1,b2:integer;
        g:text;
        dd:boolean;
procedure enter;
var i:longint;
begin
        assign(g,fi);
        reset(g);
        readln(g,a,b);
        readln(g,a1,b1);
        read(g,a2,b2);
        close(g);
end;

procedure try(x,y,a,b,k:longint);
begin
        if (x>a) or (y>b) then exit;
        if k=2 then begin dd:=true;exit;    end;
        try(a2,b2,a-x,b,2);
        try(b2,a2,a-x,b,2);
        try(a2,b2,a,b-y,2);
        try(b2,a2,a,b-y,2);
end;
procedure main;
begin
        dd:=false;
        try(a1,b1,a,b,1);try(b1,a1,a,b,1);
end;


procedure print;
begin
        assign(g,fo);
        rewrite(g);
        if dd then write(g,'YES') ELSE WRITE(G,'NO');
        close(g);
end;

begin
        enter;
        main;
        print;
end.