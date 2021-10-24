Const fi='ford.inp';
   fo='ford.out';
var n,m,nheap,x,y  :  longint;
  a,link,head,d,item,pos,c:  array[1..100000]of longint;
procedure nhap;
var f:Text;
  i,u:  longint;
begin
    assign(f,fi);
    reset(f);
    readln(f,n,m,x,y);
    for i:=1 to m do
      begin
          readln(f,u,a[i],c[i]);
          link[i]:=head[u];
          head[u]:=i;
      end;
    close(f);
end;
procedure upd(v:  longint);
var p,c:  longint;
begin
    c:=pos[v];
    if c=0 then
      begin
          inc(nheap);
          c:=nheap;
      end;
    repeat
      p:=c div 2;
      if (p=0)or(d[item[p]]<=d[v]) then break;
      item[c]:=item[p];
      pos[item[c]]:=c;
      c:=p;
    until false;
    item[c]:=v;
    pos[v]:=c;
end;
function tim:  longint;
var p,v,c:  longint;
begin
    tim:=item[1];
    v:=item[nheap];
    dec(nheap);
    p:=1;
    repeat
       c:=p*2;
       if (c<nheap)and(d[item[c]]>d[item[c+1]]) then inc(c);
       if (c>nheap)or(d[v]<=d[item[c]]) then break;
       item[p]:=item[c];
       pos[item[p]]:=p;
       p:=c;
    until false;
    item[p]:=v;
    pos[v]:=p;
end;
procedure xuli;
var i,u:  longint;
begin
    for i:=1 to n do
      begin
          d[i]:=maxlongint;
          pos[i]:=0;
      end;
    nheap:=1;
    item[1]:=x;
    d[x]:=0;
    pos[x]:=1;
    repeat
      u:=tim;
      i:=head[u];
      while i<>0 do
        begin
            if d[a[i]]>d[u]+c[i] then
              begin
                  d[a[i]]:=d[u]+c[i];
                  upd(a[i]);
              end;
            i:=link[i];
        end;
    until (nheap=0)or(u=y);
end;
procedure xuat;
var f:Text;
begin
    assign(f,fo);
    rewrite(f);
    if d[y]<> maxlongint then
      begin
         writeln(f,'YES');
         write(f,d[y]);
      end
    else write(f,'NO');
    close(f);
end;
begin
    nhap;
    xuli;
    xuat;
end.
