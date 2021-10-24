const   ginp='welcome.inp';
        gout='welcome.out';

var     gi,go:text;
        n:longint;
        t,s,p,f:array[0..1001] of int64;
        ans:int64;

procedure swap(var x,y:int64);
var     tmp:int64;
begin
        tmp:=x;
        x:=y;
        y:=tmp;
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do readln(gi,t[i],s[i],p[i]);
end;

function cdt(i,j:longint):boolean;
begin
        if (t[i]-t[j])>=abs(s[i]-s[j]) then exit(true) else exit(false);
end;

procedure process;
var     i,j:longint;
begin
        for i:=1 to n-1 do
                for j:=i+1 to n do
                        if t[i]>t[j] then
                        begin
                                swap(t[i],t[j]);
                                swap(s[i],s[j]);
                                swap(p[i],p[j]);
                        end;
        ans:=0;
        fillchar(f,sizeof(f),0);
        for i:=1 to n do
                if (t[i]<=2000000000) and (cdt(i,0)) then
                begin
                        f[i]:=p[i];
                        for j:=1 to i-1 do
                                if cdt(i,j) then f[i]:=max(f[i],f[j]+p[i]);
                        ans:=max(ans,f[i]);
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
