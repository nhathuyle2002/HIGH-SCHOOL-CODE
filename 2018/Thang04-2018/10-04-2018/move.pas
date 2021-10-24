const   ginp='move.inp';
        gout='move.out';

var     gi,go:text;
        n,m,ans:longint;
        ct,cp,f,a:array[0..101,0..10001] of longint;

procedure input;
var     i,j:longint;
        ok:boolean;
        s:ansistring;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(Go);
        readln(gi,m,n);
        for i:=1 to m do
        begin
                ok:=false;
                readln(gi,s);
                for j:=1 to n do
                begin
                        a[i,j]:=ord(s[j])-48;
                        if a[i,j]=1 then ok:=true;
                end;
                if ok=false then
                begin
                        write(go,-1);
                        close(gi);close(go);
                        halt;
                end;
        end;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure create;
var     i,j:longint;
begin
        for i:=1 to m do
        begin
                for j:=n downto 1 do
                        if a[i,j]=1 then break;
                ct[i,0]:=j-n;
                for j:=1 to n do
                        if a[i,j]=1 then ct[i,j]:=j
                        else ct[i,j]:=ct[i,j-1];
                for j:=1 to n do
                        if a[i,j]=1 then break;
                cp[i,n+1]:=j+n;
                for j:=n downto 1 do
                        if a[i,j]=1 then cp[i,j]:=j
                        else cp[i,j]:=cp[i,j+1];
                for j:=1 to n do
                        f[i,j]:=min(j-ct[i,j],cp[i,j]-j);
        end;
end;

procedure process;
var     i,j,k,sum:longint;
begin
        ans:=maxlongint;
        for j:=1 to n do
        begin
                sum:=0;
                for i:=1 to m do sum:=sum+f[i,j];
                ans:=min(ans,sum);
        end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        create;
        process;
        output;
end.










