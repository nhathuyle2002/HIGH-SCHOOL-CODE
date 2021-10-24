const   ginp='pushups.inp';
        gout='pushups.out';

var     gi,go:text;
        n,m:longint;
        s:array[0..100] of longint;
        kq:int64;
        f:array[0..5001,0..501] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do read(gi,s[i]);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure process;
var     i,j,k:longint;
        tmp:int64;
begin
        fillchar(f,sizeof(f),false);
        for i:=1 to m do f[s[i],s[i]]:=true;
        for i:=1 to n do
                for j:=1 to 500 do
                        if f[i,j]=true then
                        for k:=1 to m do
                        begin
                                tmp:=i+j+s[k];
                                if tmp<=n then f[tmp,j+s[k]]:=true;
                        end;
        for i:=1 to 500 do
                if f[n,i] then kq:=i;
end;

procedure output;
begin
        if kq=0 then write(go,-1) else write(go,kq);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.