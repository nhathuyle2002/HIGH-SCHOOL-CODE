const   ginp='ss.inp';
        gout='ss.out';
        oo=trunc(1e14);
        maxn=1000004;

type    giatri=record g,v:int64;end;

var     gi,go:text;
        n:longint;
        res:giatri;
        sum:int64;
        a,s:array[0..maxn] of int64;
        fma,fmi:array[0..maxn] of giatri;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        s[0]:=0;
        for i:=1 to n do
        begin
                read(gi,a[i]);
                s[i]:=s[i-1]+a[i];
        end;
end;

function abs(x:int64):int64;
begin
        if x<0 then exit(-x) else exit(x);
end;

procedure process;
var     i:longint;
begin
        fma[0].g:=-oo;fmi[0].g:=oo;
        for i:=1 to n do
        begin
                fma[i]:=fma[i-1];
                fmi[i]:=fmi[i-1];
                if s[i]=fma[i].g then inc(fma[i].v);
                if s[i]=fmi[i].g then inc(fmi[i].v);
                if s[i]>fma[i].g then
                begin
                        fma[i].g:=s[i];
                        fma[i].v:=1;
                end;
                if s[i]<fmi[i].g then
                begin
                        fmi[i].g:=s[i];
                        fmi[i].v:=1;
                end;
        end;
        res.g:=-oo;sum:=0;
        for i:=n downto 2 do
        begin
                sum:=sum+a[i];
                if abs(sum-fma[i-1].g)=res.g then
                        res.v:=res.v+fma[i-1].v;
                if (abs(sum-fmi[i-1].g)=res.g) and (fmi[i-1].g<>fma[i-1].g) then
                        res.v:=res.v+fmi[i-1].v;
                if abs(sum-fma[i-1].g)>res.g then
                begin
                        res.g:=abs(sum-fma[i-1].g);
                        res.v:=fma[i-1].v;
                end;
                if abs(sum-fmi[i-1].g)>res.g then
                begin
                        res.g:=abs(sum-fmi[i-1].g);
                        res.v:=fmi[i-1].v;
                end;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        write(go,res.g,' ',res.v);
        close(gi);close(go);
end.
