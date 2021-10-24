const   ginp='swindow.inp';
        gout='swindow.out';

var     gi,go:text;
        t,p:ansistring;
        m,n,k,res:longint;
        d:array[0..2000010] of boolean;
        z:array[0..2000010] of longint;

procedure input;
begin
        readln(gi,t);
        readln(gi,p);m:=length(p);
        read(gi,k);
        t:=p+'*'+t;n:=length(t);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,l,r,j:longint;
begin
        res:=0;
        if k<m then exit;
        fillchar(d,sizeof(d),true);
        l:=1;r:=1;
        for i:=2 to n do
        begin
                if i<=r then z[i]:=min(r-i+1,z[i-l+1]);
                while (i+z[i]<=n) and (t[1+z[i]]=t[i+z[i]]) do inc(z[i]);
                if z[i]=m then
                begin
                        j:=i+k-1;
                        if j>n then j:=n;
                        while (j>=i+m-1) and (j>m+k) and (d[j]) do
                        begin
                                d[j]:=false;
                                inc(res);dec(j);
                        end;
                end;
                if r<i+z[i]-1 then
                begin
                        l:=i;r:=i+z[i]-1;
                end;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,res);
        close(gi);close(go);
end.
