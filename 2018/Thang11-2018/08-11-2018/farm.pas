const   gi='farm.inp';
        go='farm.out';
        ti:array[1..4] of integer= (-1,1,0,0);
        tj:array[1..4] of integer= (0,0,-1,1);

var     g:text;
        d:array[0..1001,0..1001] of char;
        m,n,c,s,dc,ds:longint;
        ok:boolean;

procedure input;
var     i,j:longint;
begin
        assign(g,gi);
        reset(g);
        readln(g,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(g,d[i,j]);
                readln(g);
        end;
        close(g);
end;

function cdt(x,y:longint):boolean;
begin
        if (x=0) or (y=0) or (x=m+1) or (y=n+1) then
        begin
                //ok:=true;
                exit(false);
        end
        else exit(true);
end;

procedure tick(x,y:longint);
var     i:longint;
begin
        if d[x,y]='#' then exit;
        if d[x,y]='f' then inc(ds);
        if d[x,y]='c' then inc(dc);
        d[x,y]:='#';
        for i:=1 to 4 do
                if cdt(x+ti[i],y+tj[i])
                then tick(x+ti[i],y+tj[i]);
end;

procedure output;
var     i,j,dems,demc:longint;
begin
        assign(g,go);
        rewrite(g);
        dems:=0;
        demc:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if (d[i,j]='.') or (d[i,j]='f') or (d[i,j]='c') then
                        begin
                                ds:=0;
                                dc:=0;
                                ok:=false;
                                tick(i,j);
                                if (dc>ds) or (ok) then demc:=demc+dc;
                                if (dc<=ds) or (ok) then dems:=dems+ds;
                        end;
        write(g,dems,' ',demc);
        close(g);
end;

begin
        input;
        output;
end.





















