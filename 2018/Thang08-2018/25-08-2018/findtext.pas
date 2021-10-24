const   ginp='findtext.inp';
        gout='findtext.out';

var     n,res,rr:longint;
        a:ansistring;
        z:array[0..10000010] of longint;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,l,r:longint;
begin
        read(a);n:=length(a);
        z[1]:=0;res:=1;rr:=0;
        l:=1;r:=1;
        for i:=2 to n do
        begin
                if i<=r then z[i]:=min(r-i+1,z[i-l+1]);
                while (i+z[i]<=n) and (a[1+z[i]]=a[i+z[i]]) do inc(z[i]);
                if r<i+z[i]-1 then
                begin
                        l:=i;r:=i+z[i]-1;
                end;
                if rr<min(z[i],i-1) then
                begin
                        res:=i;
                        rr:=min(z[i],i-1);
                end;
        end;
        write(rr,' ',res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
