const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,res:longint;
        a,f:array[-101..301] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        for i:=1 to n do read(gi,a[i]);
        for i:=0 downto -n+1 do a[i]:=a[i+n];
        for i:=n+1 to 2*n do a[i]:=a[i-n];
        for i:=-n+1 to 2*n do
                if a[i] mod 2=0 then f[i]:=f[i-2] else f[i]:=f[i-2]+1;
end;

procedure process;
var     i,tm1,tm2:longint;
        ok:boolean;
begin
        res:=0;
        for i:=1 to n do
        begin
                ok:=true;
                if n mod 2=0 then
                begin
                        tm1:=f[i+n-2]-f[i-2];
                        tm2:=f[i+n-1]-f[i-1];
                        if tm2>=tm1 then ok:=false;
                end;
                if n mod 2=1 then
                begin
                        tm1:=f[i+n-1]-f[i-2];
                        tm2:=f[i+n-2]-f[i-1];
                        if tm2>=tm1 then ok:=false;
                        tm1:=f[i]-f[i-n-1];
                        tm2:=f[i-1]-f[i-n];
                        if tm2>=tm1 then ok:=false;
                end;
                if ok then inc(res);
        end;
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.
