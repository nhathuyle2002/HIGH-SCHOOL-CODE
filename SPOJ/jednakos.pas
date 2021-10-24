const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e5);

var     gi,go:text;
        n,m:longint;
        s:ansistring;
        r:array[0..1010] of longint;
        f:array[0..1010,0..5100] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     v,i:longint;
begin
        read(gi,s);
        v:=pos('=',s);
        val(copy(s,v+1,length(s)-v),m);
        delete(s,v,length(s)-v+1);
        n:=length(s);
        r[n+1]:=n+1;r[0]:=2;
        for i:=n downto 1 do
                if s[i]='0' then r[i]:=r[i+1] else r[i]:=i+1;
end;

procedure process;
var     i,j,k,sum,tm:longint;
begin
        for i:=0 to n do
                for j:=0 to m do f[i,j]:=oo;
        f[0,0]:=-1;
        for i:=0 to n-1 do
        for j:=0 to m do
                if f[i,j]<>oo then
                begin
                        sum:=0;
                        for k:=r[i+1]-1 to n do
                        begin
                                sum:=sum*10+ord(s[k])-48;
                                if sum>m then break;
                                if sum+j<=m then
                                f[k,j+sum]:=min(f[k,j+sum],f[i,j]+1);
                        end;
                end;
        write(go,f[n,m]);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
