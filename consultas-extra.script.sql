-- Listar las pistas ordenadas por el número de veces que aparecen en playlists de forma descendente
SELECT	T.Name,
		COUNT(PT.TrackId) AS VecesEnLista
FROM Track T
INNER JOIN PlaylistTrack PT
ON T.TrackId = PT.TrackId
GROUP BY T.Name
ORDER BY VecesEnLista DESC

-- Listar las pistas más compradas (la tabla InvoiceLine tiene los registros de compras)
SELECT	T.Name,
		COUNT(I.TrackId) AS VecesComprado
FROM Track T
INNER JOIN InvoiceLine I
ON T.TrackId = I.TrackId
GROUP BY T.Name
ORDER BY VecesComprado DESC

-- Listar los artistas más comprados
SELECT	A.Name,
		COUNT(I.TrackId) AS VecesComprado
FROM Artist A
INNER JOIN Album AL
ON A.ArtistId = AL.ArtistId
INNER JOIN Track T
ON AL.AlbumId = T.AlbumId
INNER JOIN InvoiceLine I
ON T.TrackId = I.TrackId
GROUP BY A.Name
ORDER BY VecesComprado DESC

-- Listar las pistas que aún no han sido compradas por nadie
SELECT	T.TrackId,
		T.Name
FROM Track T
LEFT JOIN InvoiceLine I 
ON T.TrackId = I.TrackId
WHERE I.TrackId IS NULL

-- Listar los artistas que aún no han vendido ninguna pista
SELECT	A.Name,
		COUNT(I.InvoiceId) AS VecesComprado
FROM Artist A
LEFT JOIN Album AL 
ON A.ArtistId = AL.ArtistId
LEFT JOIN Track T 
ON AL.AlbumId = T.AlbumId
LEFT JOIN InvoiceLine I
ON T.TrackId = I.TrackId
GROUP BY A.ArtistId, A.Name
HAVING COUNT(I.InvoiceId) = 0