const   ginp='onecbl.inp';
        gout='onecbl.out';

var     gi,go:text;
        n,m,u,v:longint;
        ok:boolean;
        vao,ra:array[0..2001] of longint;

procedure input;
var     i,x,y:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        for i:=1 to m do
        begin
                readln(gi,x,y);
                vao[y]:=1;
                ra[x]:=1;
        end;
end;

procedure process;
var     i,dem1,dem2:longint;
begin
        ok:=false;
        dem1:=0;dem2:=0;
        for i:=1 to n do
        begin
                if ra[i]=1 then inc(dem1);
                if vao[i]=1 then inc(dem2);
        end;
        if (dem1<>n-1) or (dem2<>n-1) then exit;
        ok:=true;
        for u:=1 to n do
                if ra[u]=0 then break;
        for v:=1 to n do
                if vao[v]=0 then break;
end;

procedure output;
begin
        if ok=false then write(go,'NO')
        else
        begin
                writeln(go,'YES');
                write(go,u,' ',v);
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.














