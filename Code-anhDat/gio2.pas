const   ginp='gio.inp';
        gout='gio.out';

var     n:longint;
        s:string;
        x,y:array[0..51] of int64;
        d:array[0..51] of boolean;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do readln(x[i],y[i]);
        read(s);
end;

procedure process;
var     i,v,vv,dd:longint;
        sum:int64;
begin
        fillchar(d,sizeof(d),true);
        v:=1;
        for i:=2 to n do
                if y[i]<y[v] then v:=i;
        write(v,' ');vv:=v;d[v]:=false;
        for dd:=1 to n-2 do
        begin
                if s[dd]='L' then
                begin
                        for i:=n downto 1 do
                                if d[i] then v:=i;
                        for i:=v+1 to n do
                                if d[i] then
                                begin
                                        sum:=(x[v]-x[vv])*(y[v]+y[vv]);
                                        sum:=sum+(x[i]-x[v])*(y[i]+y[v]);
                                        sum:=sum+(x[vv]-x[i])*(y[vv]+y[i]);
                                        if sum>0 then v:=i;
                                end;
                end else
                begin
                        for i:=n downto 1 do
                                if d[i] then v:=i;
                        for i:=v+1 to n do
                                if d[i] then
                                begin
                                        sum:=(x[v]-x[vv])*(y[v]+y[vv]);
                                        sum:=sum+(x[i]-x[v])*(y[i]+y[v]);
                                        sum:=sum+(x[vv]-x[i])*(y[vv]+y[i]);
                                        if sum<0 then v:=i;
                                end;
                end;
                write(v,' ');vv:=v;d[v]:=false;
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
