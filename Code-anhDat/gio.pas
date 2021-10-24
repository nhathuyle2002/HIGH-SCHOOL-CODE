const   ginp='gio.inp';
        gout='gio.out';

type    point=record x,y:int64;end;

var     n:longint;
        s:string;
        a:array[0..51] of point;
        d:array[0..51] of boolean;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i].x,a[i].y);
        read(s);
end;

function tdt(x,y,z:point):int64;
begin
        tdt:=(y.x-x.x)*(y.y+x.y);
        tdt:=tdt+(z.x-y.x)*(z.y+y.y);
        tdt:=tdt+(x.x-z.x)*(x.y+z.y);
end;

procedure process;
var     i,v,dd:longint;
        p:point;
begin
        fillchar(d,sizeof(d),true);
        v:=1;
        for i:=2 to n do
                if a[i].y<a[v].y then v:=i;
        write(v,' ');p:=a[v];d[v]:=false;
        for dd:=1 to n-2 do
        begin
                if s[dd]='L' then
                begin
                        for i:=n downto 1 do
                                if d[i] then v:=i;
                        for i:=v+1 to n do
                                if (d[i]) and (tdt(p,a[v],a[i])>0) then v:=i;
                end else
                begin
                        for i:=n downto 1 do
                                if d[i] then v:=i;
                        for i:=v+1 to n do
                                if (d[i]) and (tdt(p,a[v],a[i])<0) then v:=i;
                end;
                write(v,' ');p:=a[v];d[v]:=false;
        end;
        for i:=1 to n do
                if d[i] then write(i);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
