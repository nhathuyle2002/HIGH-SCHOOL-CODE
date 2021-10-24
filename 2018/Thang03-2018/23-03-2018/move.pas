const   ginp='move.inp';
        gout='move.out';
        vocung=100000000000000000;

var     gi,go:text;
        n,f,l:longint;
        t,d:array[0..201] of int64;
        w:array[0..201,0..201] of int64;
        put:array[0..201] of boolean;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,f,l);
        for i:=1 to n do read(gi,t[i]);
        readln(gi);
        for i:=1 to n do
                for j:=1 to n do w[i,j]:=vocung;
        while not (eof(gi)) do
        begin
                readln(gi,i,j);
                w[i,j]:=abs(t[i]-t[j]);
                w[j,i]:=w[i,j];
        end;
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

procedure dijkstra;
var     i,u,v:longint;
        tmp:int64;
begin
        fillchar(put,sizeof(put),true);
        for i:=0 to n do d[i]:=vocung;
        d[f]:=0;
        repeat
                u:=0;
                for i:=1 to n do
                        if (put[i]) and (d[i]<d[u]) then u:=i;
                put[u]:=false;
                if (u=0) or (u=l) then exit;
                for v:=1 to n do
                        if w[u,v]<>vocung then
                        begin
                                tmp:=max(d[u],w[u,v]);
                                d[v]:=min(d[v],tmp);
                        end;
        until false;
end;

procedure output;
begin
        if put[l] then write(go,-1)
        else write(go,d[l]);
        close(gi);close(go);
end;

begin
        input;
        dijkstra;
        output;
end.










