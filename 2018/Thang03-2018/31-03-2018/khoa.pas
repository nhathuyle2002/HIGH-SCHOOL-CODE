const   ginp='khoa.inp';
        gout='khoa.out';

var     gi,go:text;
        n,spt,cou,ans:longint;
        a,sh:array[0..5001] of longint;
        d:array[0..1000001] of longint;

function exist(x:longint):boolean;
var     i:longint;
begin
        for i:=spt downto 1 do
                if sh[i]=x then exit(false);
        exit(true);
end;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                if exist(a[i]) then
                begin
                        inc(spt);
                        sh[spt]:=a[i];
                end;
        end;
end;

procedure dequy(i:longint);
begin
        if d[a[i]]=cou then exit;
        d[a[i]]:=cou;
        dequy(a[i]);
end;

procedure process;
var     i:longint;
        dd:array[0..5001] of boolean;
begin
        fillchar(d,sizeof(d),0);
        for i:=1 to n do
                if d[a[i]]=0 then
                begin
                        inc(cou);
                        dequy(i);
                end;
        fillchar(dd,sizeof(dd),true);
        for i:=1 to spt do
                if dd[d[sh[i]]] then
                begin
                        inc(ans);
                        dd[d[sh[i]]]:=false;
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












