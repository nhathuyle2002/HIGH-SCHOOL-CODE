program divn;
uses crt;
const fi='div.inp';
        fo='div.out';
var  m,k:longint;
         kq:int64;
         n:int64;
        a:array[0..1000009] of longint;
        f,g:text;
        d:array[0..1000009] of boolean;

procedure san;
var i,j:longint;
begin
        k:=0;
        for i:=2 to 1000000 do
        if not d[i] then
        begin
                inc(k);
                a[k]:=i;
                j:=2*i;
                while j<=1000000 do begin
                d[j]:=true;
                j:=j+i;
                end;
        end;
end;
procedure xuly;
var c1,c2,z:int64;
        i:longint ;
begin
        n:=int64(m)*(m+1)*(m+2);
        c1:=1;
        c2:=1;
        for i:=1 to k do
        begin
                z:=0;

                while n mod a[i]=0 do
                begin
                        n:=n div a[i];
                        inc(z);
                        if n=1 then break;
                end;

                c1:=c1*(z+1);
                c2:=c2*(z*2+1);
                if n=1 then break;
        end;
        kq:=(c2-1)div 2 -c1+1;

end;
procedure nhap;
var l,i:longint;
begin
        san;
        assign(f,fi);
        reset(F);
        assign(g,fo);
        rewrite(g);

        readln(f,l);
        for i:=1 to l do
        begin
                readln(f,m);
                xuly;
                writeln(g,kq);
        end;
        close(F);
        close(G);
end;
begin
        nhap;
end.
