const   fi='WORD.INP';
        fo='WORD.OUT';
        base2=trunc(1e7);
type    trie=^node;
        node=record
        c:array['a'..'z'] of trie;
        end;
var     s:string;
        n,nn:longint;
        a:array[1..1000] of string;
        c:array[1..1000] of longint;
        t:array[0..30] of int64;
        dd,gt:array[0..10000000] of longint;
        d:array[0..1000,0..1000] of boolean;
        f:array[0..1000,0..1000] of longint;
        base:int64;
        goc:trie;
procedure       nhap;
var     f:text;
        i:longint;
begin
        assign(f,fi); reset(f);
        readln(f,s);
        readln(f,n);
        for i:=1 to n do
                begin
                        readln(f,a[i]);
                        readln(f,c[i]);
                end;
        close(F);
end;
function        max(a,b:longint):longint;
begin
        if a>b then max:=a else max:=b;
end;
procedure       tao(var x:trie);
var     c:char;
begin
        new(X);
        for c:='a' to 'z' do
                x^.c[c]:=nil;
end;
function       khoitao:boolean;
var     i,j:longint;
        h:int64;
        tmp:trie;
begin
        tao(goc);
        for i:=0 to base2 do
                dd[i]:=0;
        for i:=1 to n do
        begin
                tmp:=goc;
                h:=0;
                for j:=1 to length(a[i]) do
                begin
                        h:=(h*27+ord(a[i][j])-ord('a')+1) mod base;
                        if tmp^.c[a[i][j]]=nil then tao(tmp^.c[a[i][j]]);
                        tmp:=tmp^.c[a[i][j]];
                end;
                h:=h mod base2;
                if (dd[h]=0) or (a[i]=a[dd[h]]) then
                begin
                        if dd[h]=0 then
                                gt[h]:=c[i]
                        else    gt[h]:=max(gt[h],c[i]);
                        dd[h]:=length(a[i]);
                end
                else
                exit(false);
        end;
        exit(true);
end;
procedure       capnhat(i,j,c:longint);
begin
        d[i,j]:=true;
        if f[i,j]<c then f[i,j]:=c;
end;
procedure       xuli;
var     i,j,res,u,v,ghu,ghv,k,k2:longint;
        h1,h2,h:int64;
        tmp:trie;
begin
        nn:=length(s);
        f[1,nn]:=-1;
        t[0]:=1;
        for i:=1 to nn do
                d[i,i-1]:=true;
        for i:=1 to 30 do
                t[i]:=(t[i-1]*27) mod base;
        for res:=1 to nn do
                for i:=1 to nn-res+1 do
                begin
                        j:=i+res-1;
                        h1:=0;
                        for k:=i to j do
                                if d[i,k-1] and d[k,j] then
                                        capnhat(i,j,f[i,k-1]+f[k,j]);
                        for k:=1 to 30 do
                        begin
                                u:=i+k-1;
                                h1:=(h1*27+ord(s[u])-ord('a')+1) mod base;
                                if u=j then
                                        break;
                                h2:=0;
                                for k2:=1 to 30 do
                                begin
                                        v:=j-k2+1;
                                        if v=u then
                                        begin
                                                break;
                                        end;
                                        h2:=(h2+(ord(s[v])-ord('a')+1)*t[k2-1]) mod base;
                                        h:=((h1*t[k2]+h2) mod base) mod base2;
                                        if (d[u+1,v-1]) and (dd[h]=k+k2) then
                                                capnhat(i,j,gt[h]+f[u+1,v-1]);
                                end;
                        end;
                end;
end;
procedure       xuat;
var     g:text;
begin
        assign(g,fo); rewrite(g);
        write(g,f[1,nn]);
        close(g);
end;
procedure       taotest;
var     g:text;
        i,j:longint;
begin
        assign(g,fi); rewrite(g);
        for i:=1 to 90 do write(g,'a');
        writeln(g);
        writeln(g,1000);
        for i:=1 to 1000 do
        begin
                for j:=1 to 30 do write(g,'a');
                writeln(g);
                writeln(g,10000);
        end;
        close(g);
end;
begin
//        taotest;
        nhap;
        base:=trunc(1e9)+7;
        if khoitao=false then
        begin
                base:=base+2;
                if khoitao=false then
                        begin
                                base:=1000000000;
                                if khoitao=false then exit;
                        end;
        end;
        xuli;
        xuat;
end.
