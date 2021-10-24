const   ginp='lcis.inp';
        gout='lcis.out';

var     gi,go:text;
        m,n,ans,vti,vtj:longint;
        a,b,f:array[0..3010] of longint;
        trace:array[0..3010,0..3010] of longint;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do read(gi,a[i]);readln(gi);
        for i:=1 to n do read(gi,b[i]);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure D_P;
var     i,j,tm:longint;
begin
        ans:=0;
        for i:=1 to m do
        begin
                tm:=0;
                for j:=1 to n do
                begin
                        trace[i,j]:=-1;
                        if (b[j]<a[i]) and (f[j]>f[tm]) then tm:=j else
                        if (a[i]=b[j]) and (f[j]<f[tm]+1) then
                        begin
                                f[j]:=f[tm]+1;
                                trace[i,j]:=tm;
                        end;
                        if f[j]>ans then
                        begin
                                ans:=f[j];
                                vti:=i;vtj:=j;
                        end;
                end;
        end;
end;

procedure output;
var     i,sl:longint;
        ou:array[0..3010] of longint;
begin
        writeln(go,ans);
        sl:=0;
        while (vti<>0) and (vtj<>0) do
        begin
                if trace[vti,vtj]=-1 then dec(vti) else
                begin
                        inc(sl);
                        ou[sl]:=vtj;
                        vtj:=trace[vti,vtj];
                end;
        end;
        for i:=sl downto 1 do write(go,b[ou[i]],' ');
        close(gi);close(go);
end;

begin
        input;
        D_P;
        output;
end.






