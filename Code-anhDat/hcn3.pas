const   ginp='hcn.inp';
        gout='hcn.out';

type    save=record g,i,j:longint;end;

var     m,n,nm:longint;
        d,dd:array[0..1010,0..1010] of boolean;
        b:array[0..1000010] of save;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:save;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i].g>t.g do inc(i);
                while b[j].g<t.g do dec(j);
                if i<=j then
                begin
                        tm:=b[i];b[i]:=b[j];b[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i,j:longint;
begin
        readln(m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        inc(nm);read(b[nm].g);
                        b[nm].i:=i;b[nm].j:=j;
                end;
                readln;
        end;
        sort(1,nm);
end;

procedure process;
var     i,j:longint;
begin
        fillchar(d,sizeof(d),false);
        fillchar(dd,sizeof(dd),false);
        for i:=1 to nm do
        begin
                for j:=1 to b[i].j-1 do
                        if d[b[i].i,j] then
                        begin
                                if dd[j,b[i].j] then
                                begin
                                        write(b[i].g);
                                        exit;
                                end;
                                dd[j,b[i].j]:=true;
                        end;
                for j:=b[i].j+1 to n do
                        if d[b[i].i,j] then
                        begin
                                if dd[b[i].j,j] then
                                begin
                                        write(b[i].g);
                                        exit;
                                end;
                                dd[b[i].j,j]:=true;
                        end;
                d[b[i].i,b[i].j]:=true;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
