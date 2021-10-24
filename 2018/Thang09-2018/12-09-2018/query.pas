const   ginp='query.inp';
        gout='query.out';
        maxn=1010;

var     m,n:longint;
        a,bit:array[0..1010,0..1010] of int64;

function quece(x,y:longint):int64;
var     i,j:longint;
begin
        quece:=0; i:=x;
        while i>0 do
        begin
                j:=y;
                while j>0 do
                begin
                        quece:=quece+bit[i,j];
                        j:=j-j and (-j);
                end;
                i:=i-i and (-i);
        end;
end;

procedure update(x,y:longint; w:int64);
var     i,j:longint;
begin
        i:=x;
        while i<=m do
        begin
                j:=y;
                while j<=n do
                begin
                        bit[i,j]:=bit[i,j]+w;
                        j:=j+j and (-j);
                end;
                i:=i+i and (-i);
        end;
end;

procedure process;
var     x,y,x0,y0,q,t:longint;
        res,w:int64;
        id:string[1];
begin
        readln(m,n,q);
        for t:=1 to q do
        begin
                read(id);
                if id='S' then
                begin
                        readln(x,y,w);
                        update(x,y,w-a[x,y]);
                        a[x,y]:=w;
                end else
                begin
                        readln(x0,y0,x,y);
                        res:=quece(x,y)-quece(x0-1,y)-quece(x,y0-1)+quece(x0-1,y0-1);
                        writeln(res);
                end;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        process;
        close(input);close(output);
end.
