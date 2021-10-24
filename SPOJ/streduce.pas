const   ginp='ss.inp';
        gout='ss.out';

var     n:longint;
        a:ansistring;
        f:array[0..301,0..301] of longint;
        d:array[0..301,0..301,1..6] of boolean;

function ms(x:ansistring):longint;
begin
        if x='a' then ms:=1 else
        if x='b' then ms:=2 else
        if x='aa' then ms:=3 else
        if x='bb' then ms:=4 else
        if x='ab' then ms:=5 else
        if x='ba' then ms:=6;
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,k,j,kc:longint;
begin
        read(a);n:=length(a);
        fillchar(d,sizeof(d),false);
        for i:=1 to n do
        begin
                d[i,i,ms(a[i])]:=true;
                f[i,i]:=1;
        end;
        for i:=1 to n-1 do
        begin
                d[i,i+1,ms(a[i]+a[i+1])]:=true;
                f[i,i+1]:=2;
        end;
        for kc:=2 to n-1 do
        begin
                for i:=1 to n-kc do
                begin
                        j:=i+kc;f[i,j]:=n+1;
                        for k:=i to j-1 do
                        begin
                                f[i,j]:=min(f[i,j],f[i,k]+f[k+1,j]);
                                if (d[i,k,1] and d[k+1,j,3]) or (d[i,k,3] and d[k+1,j,1]) or (d[i,k,6] and d[k+1,j,2]) then d[i,j,1]:=true;
                                if (d[i,k,2] and d[k+1,j,4]) or (d[i,k,4] and d[k+1,j,2]) or (d[i,k,5] and d[k+1,j,1]) then d[i,j,2]:=true;
                                if (d[i,k,1] and d[k+1,j,1]) or (d[i,k,3] and d[k+1,j,3]) then d[i,j,3]:=true;
                                if (d[i,k,2] and d[k+1,j,2]) or (d[i,k,4] and d[k+1,j,4]) then d[i,j,4]:=true;
                                if (d[i,k,1] and d[k+1,j,2]) or (d[i,k,3] and d[k+1,j,6]) then d[i,j,5]:=true;
                                if (d[i,k,2] and d[k+1,j,1]) or (d[i,k,4] and d[k+1,j,5]) then d[i,j,6]:=true;
                        end;
                        for k:=1 to 2 do
                                if d[i,j,k] then f[i,j]:=1;
                        for k:=3 to 6 do
                                if d[i,j,k] then f[i,j]:=min(f[i,j],2);
                end;
        end;
        write(f[1,n]);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
